import 'dart:async';
import 'package:children_rewards/features/rule/domain/repositories/i_rules_repository.dart';
import 'package:children_rewards/features/rule/providers/rules_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart';
import 'package:children_rewards/features/idiom_game/domain/services/idiom_game_service.dart';
import 'package:children_rewards/features/idiom_game/providers/idiom_game_providers.dart';
import 'package:children_rewards/features/points/data/point_records_repository.dart';
import 'package:children_rewards/features/points/providers/point_records_providers.dart';
import 'package:characters/characters.dart';
import 'package:children_rewards/core/logging/app_logger.dart';

// Represents the state of the idiom game
class IdiomGameState {
  final GameStatus status;
  final GameConfig config;
  final int grade;
  final List<IdiomChainLink> chain;
  final int remainingTime;
  final int freeHints;
  final int hintsUsed;
  final int fastAnswerCount;
  final int rareIdiomCount;
  final int playerTurns;
  final int timeoutWarningCount;
  final bool isAiSurrender;
  final DateTime? turnStartTime;
  final int combo;
  final int starsEarned;
  final List<String>? currentHints;
  final Idiom? failureCompensation;
  final GameError? error;
  final ScoreBreakdown? scoreBreakdown;

  const IdiomGameState({
    this.status = GameStatus.initializing,
    required this.config,
    this.grade = 1,
    this.chain = const [],
    this.remainingTime = 0,
    this.freeHints = 3,
    this.hintsUsed = 0,
    this.fastAnswerCount = 0,
    this.rareIdiomCount = 0,
    this.playerTurns = 0,
    this.timeoutWarningCount = 0,
    this.isAiSurrender = false,
    this.turnStartTime,
    this.combo = 0,
    this.starsEarned = 0,
    this.currentHints,
    this.failureCompensation,
    this.error,
    this.scoreBreakdown,
  });

  IdiomGameState copyWith({
    GameStatus? status,
    GameConfig? config,
    int? grade,
    List<IdiomChainLink>? chain,
    int? remainingTime,
    int? freeHints,
    int? hintsUsed,
    int? fastAnswerCount,
    int? rareIdiomCount,
    int? playerTurns,
    int? timeoutWarningCount,
    bool? isAiSurrender,
    DateTime? turnStartTime,
    int? combo,
    int? starsEarned,
    List<String>? currentHints,
    Idiom? failureCompensation,
    GameError? error,
    ScoreBreakdown? scoreBreakdown,
  }) {
    return IdiomGameState(
      status: status ?? this.status,
      config: config ?? this.config,
      grade: grade ?? this.grade,
      chain: chain ?? this.chain,
      remainingTime: remainingTime ?? this.remainingTime,
      freeHints: freeHints ?? this.freeHints,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      fastAnswerCount: fastAnswerCount ?? this.fastAnswerCount,
      rareIdiomCount: rareIdiomCount ?? this.rareIdiomCount,
      playerTurns: playerTurns ?? this.playerTurns,
      timeoutWarningCount: timeoutWarningCount ?? this.timeoutWarningCount,
      isAiSurrender: isAiSurrender ?? this.isAiSurrender,
      turnStartTime: turnStartTime ?? this.turnStartTime,
      combo: combo ?? this.combo,
      starsEarned: starsEarned ?? this.starsEarned,
      currentHints: currentHints ?? this.currentHints,
      failureCompensation: failureCompensation ?? this.failureCompensation,
      error: error ?? this.error,
      scoreBreakdown: scoreBreakdown ?? this.scoreBreakdown,
    );
  }
}

class IdiomGameNotifier extends StateNotifier<IdiomGameState> {
  final IdiomGameService _gameService;
  final PointRecordsRepository _pointsRepository;
  final IRulesRepository _rulesRepository;
  final int _childId;
  int _currentGrade = 1;
  Timer? _timer;
  bool _timerPaused = false; // 倒计时是否暂停
  List<String> _failedLastChars = []; // 缓存失败尾字列表

  IdiomGameNotifier(this._gameService, this._pointsRepository, this._rulesRepository, this._childId)
      : super(IdiomGameState(config: GameConfig.defaultConfig())) {
    _initialize();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  Future<void> _initialize() async {
    final config = await _gameService.loadGameConfig(_childId);
    state = state.copyWith(config: config, freeHints: config.freeHintsCount, status: GameStatus.ready);
  }

  Future<void> startGame(int grade) async {
    _currentGrade = grade;
    state = state.copyWith(status: GameStatus.starting, grade: grade);

    // 获取之前失败的成语尾字，用于优先出题和接龙中间补偿
    _failedLastChars = await _gameService.getFailedLastChars(_childId);

    final result = await _gameService.startGame(
      grade,
      includeRare: state.config.includeRareIdioms,
      failedLastChars: [], // 总是随机开局，避免重复出现相同的“失败”成语
    );
    result.when(
      success: (initialLink) {
        state = state.copyWith(
          status: GameStatus.playing,
          chain: [initialLink],
          remainingTime: state.config.countdownSeconds,
          freeHints: state.config.freeHintsCount, // 重置提示次数
          hintsUsed: 0,
          fastAnswerCount: 0,
          rareIdiomCount: 0,
          playerTurns: 0,
          timeoutWarningCount: 0,
          isAiSurrender: false,
          turnStartTime: DateTime.now(),
          combo: 0,
          starsEarned: 0,
          currentHints: null,
          failureCompensation: null,
          error: null,
        );
        _startTimer();
      },
      failure: (e, _, __) => state = state.copyWith(status: GameStatus.error, error: GameError(e.toString())),
    );
  }

  Future<bool> checkIdiomCandidate(String word) async {
    if (state.status != GameStatus.playing || state.chain.isEmpty) return false;

    final lastLink = state.chain.last;
    final usedWords = state.chain.map((e) => e.word).toList();
    final result = await _gameService.validatePlayerIdiom(
      word,
      lastLink,
      matchMode: state.config.matchMode,
      usedWords: usedWords,
    );

    // Return true only if valid
    return result.when(
      success: (validation) => validation.isValid,
      failure: (_, __, ___) => false,
    );
  }

  Future<void> submitIdiom(String word) async {
    logger.info('IdiomGameProvider', 'submitIdiom: word="$word", status=${state.status}');

    if (state.status != GameStatus.playing) {
      logger.warning('IdiomGameProvider', 'submitIdiom: 忽略提交，游戏状态不是playing');
      return;
    }

    final lastLink = state.chain.last;
    final usedWords = state.chain.map((e) => e.word).toList();
    logger.info('IdiomGameProvider', 'submitIdiom: 验证成语，lastChar="${lastLink.word.characters.last}"');

    final result = await _gameService.validatePlayerIdiom(
      word,
      lastLink,
      matchMode: state.config.matchMode,
      usedWords: usedWords,
    );

    result.when(
        success: (validationResult) {
          logger.info('IdiomGameProvider', 'submitIdiom: 验证结果=${validationResult.type}, message=${validationResult.message}');

          if (validationResult.type == IdiomValidationResultType.valid) {
            final validLink = validationResult.link!;
            final newChain = List<IdiomChainLink>.from(state.chain)..add(validLink);

            // Record Engagement (Player correctly answered)
            if (validLink.idiomId != null) {
              _gameService.recordEngagement(_childId, validLink.idiomId!, isCorrect: true);
            }

            // 计算表现指标
            final now = DateTime.now();
            final turnDuration = state.turnStartTime != null ? now.difference(state.turnStartTime!) : Duration.zero;
            final isFastAnswer = turnDuration.inSeconds < 3;
            final isRare = validLink.isRare;

            state = state.copyWith(
              chain: newChain,
              combo: state.combo + 1,
              currentHints: null,
              playerTurns: state.playerTurns + 1,
              fastAnswerCount: isFastAnswer ? state.fastAnswerCount + 1 : state.fastAnswerCount,
              rareIdiomCount: isRare ? state.rareIdiomCount + 1 : state.rareIdiomCount,
              error: null, // Clear error on success
            );
            logger.info('IdiomGameProvider', 'submitIdiom: 成语有效，调用AI回复');
            _aiTurn();
          } else {
            logger.warning('IdiomGameProvider', 'submitIdiom: 成语无效 - ${validationResult.message}');
            // Use GameError for unique error events
            state = state.copyWith(error: GameError(validationResult.message ?? "无效成语"), combo: 0);
            // 验证失败，恢复倒计时让玩家重试
            resumeTimer();
          }
        },
        failure: (e, _, __) {
          logger.error('IdiomGameProvider', 'submitIdiom: 验证异常 - $e');
          state = state.copyWith(status: GameStatus.error, error: GameError(e.toString()));
        });
  }

  void _aiTurn() async {
    final playerLink = state.chain.last;
    logger.info('IdiomGameProvider', '_aiTurn: 开始AI回复，玩家成语="${playerLink.word}", 尾字="${playerLink.word.characters.last}"');

    final result = await _gameService.getAiReply(
      playerLink,
      includeRare: state.config.includeRareIdioms,
      failedLastChars: _failedLastChars,
      currentChainLength: state.chain.length,
      matchMode: state.config.matchMode,
      usedWords: state.chain.map((e) => e.word).toList(),
      avoidLastChars: state.chain.map((e) => e.word.characters.last).toList(),
    );
    result.when(
        success: (aiLink) async {
          logger.info('IdiomGameProvider', '_aiTurn: AI回复成功，成语="${aiLink.word}"');
          final newChain = List<IdiomChainLink>.from(state.chain)..add(aiLink);
          state = state.copyWith(chain: newChain, turnStartTime: DateTime.now());

          // 检查玩家是否还有可接的成语
          final usedWords = newChain.map((e) => e.word).toList();
          final hasAvailable = await _gameService.hasAvailableIdioms(
            aiLink,
            usedWords: usedWords,
            includeRare: state.config.includeRareIdioms,
            matchMode: state.config.matchMode,
          );

          if (!hasAvailable) {
            logger.info('IdiomGameProvider', '_aiTurn: 玩家没有可接的成语，游戏结束');
            final breakdown = _gameService.calculateStars(
              chainLength: newChain.length,
              grade: _currentGrade,
              hintsUsed: state.hintsUsed,
              fastAnswerCount: state.fastAnswerCount,
              playerTurns: state.playerTurns,
              rareIdiomCount: state.rareIdiomCount,
              isAiSurrender: false,
              timeoutWarningCount: state.timeoutWarningCount,
            );
            state = state.copyWith(
              error: GameError("没有可接的成语了，游戏结束！"),
            );
            _finishGame(breakdown, isWin: false);
            return;
          }

          _resetRound();
        },
        failure: (e, _, __) {
          logger.info('IdiomGameProvider', '_aiTurn: AI认输 - $e');
          // AI 认输，玩家获胜
          state = state.copyWith(isAiSurrender: true);
          final breakdown = _gameService.calculateStars(
            chainLength: state.chain.length,
            grade: _currentGrade,
            hintsUsed: state.hintsUsed,
            fastAnswerCount: state.fastAnswerCount,
            playerTurns: state.playerTurns,
            rareIdiomCount: state.rareIdiomCount,
            isAiSurrender: true,
            timeoutWarningCount: state.timeoutWarningCount,
          );
          _finishGame(breakdown, isWin: true);
        });
  }

  void _resetRound() {
    state = state.copyWith(remainingTime: state.config.countdownSeconds, currentHints: null);
    _startTimer();
  }

  void getHint() async {
    if (state.chain.isEmpty) return;
    const currentStars = 10;
    final result = await _gameService.getHint(
      state.chain.last,
      state.freeHints,
      currentStars,
      includeRare: state.config.includeRareIdioms,
      matchMode: state.config.matchMode,
    );
    result.when(
        success: (hints) {
          state = state.copyWith(
            currentHints: hints, 
            freeHints: state.freeHints > 0 ? state.freeHints - 1 : 0,
            hintsUsed: state.hintsUsed + 1,
          );
        },
        failure: (e, _, __) => state = state.copyWith(error: GameError(e.toString())));
  }

  void _startTimer() {
    _timer?.cancel();
    _timerPaused = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerPaused) return; // 暂停时跳过计时
      if (state.remainingTime > 0) {
        state = state.copyWith(remainingTime: state.remainingTime - 1);
      } else {
        timer.cancel();
        _handleTimeout();
      }
    });
  }

  /// 暂停倒计时（语音输入时调用）
  void pauseTimer() {
    _timerPaused = true;
  }

  /// 恢复倒计时（语音输入结束后调用）
  void resumeTimer() {
    _timerPaused = false;
  }

  /// 玩家主动认输
  void giveUp() {
    if (state.status != GameStatus.playing) return;
    
    // 认输时计算当前已有成绩
    final breakdown = _gameService.calculateStars(
      chainLength: state.chain.length,
      grade: _currentGrade,
      hintsUsed: state.hintsUsed,
      fastAnswerCount: state.fastAnswerCount,
      playerTurns: state.playerTurns,
      rareIdiomCount: state.rareIdiomCount,
      isAiSurrender: false,
      timeoutWarningCount: state.timeoutWarningCount,
    );
    _finishGame(breakdown, isWin: false);
  }

  void _handleTimeout() async {
    final breakdown = _gameService.calculateStars(
      chainLength: state.chain.length,
      grade: _currentGrade,
      hintsUsed: state.hintsUsed,
      fastAnswerCount: state.fastAnswerCount,
      playerTurns: state.playerTurns,
      rareIdiomCount: state.rareIdiomCount,
      isAiSurrender: false,
      timeoutWarningCount: state.timeoutWarningCount + 1,
    );

    Idiom? compensation;
    if (state.chain.isNotEmpty) {
      final lastAiLink = state.chain.last;
      
      // Record Engagement (Player failed to answer this idiom)
      if (lastAiLink.idiomId != null) {
        _gameService.recordEngagement(_childId, lastAiLink.idiomId!, isCorrect: false);
      }

      compensation = await _gameService.getFailureCompensation(
        lastAiLink,
        includeRare: state.config.includeRareIdioms,
        matchMode: state.config.matchMode,
      );

      // 记录失败的成语尾字，用于下次出题
      final lastChar = state.chain.last.word.characters.last;
      await _gameService.recordFailedLastChar(_childId, lastChar);
    }

    state = state.copyWith(failureCompensation: compensation, timeoutWarningCount: state.timeoutWarningCount + 1);
    _finishGame(breakdown, isWin: false);
  }

  void _finishGame(ScoreBreakdown breakdown, {required bool isWin}) async {
    _timer?.cancel();

    _gameService.saveGameRecord(
      childId: _childId,
      grade: _currentGrade,
      chainLength: state.chain.length,
      starsEarned: breakdown.totalStars,
      duration: 0, // 可以计算总时长，暂时传0
      hintsUsed: state.hintsUsed,
      fastAnswerCount: state.fastAnswerCount,
      playerTurns: state.playerTurns,
      rareIdiomCount: state.rareIdiomCount,
      timeoutWarningCount: state.timeoutWarningCount,
      isAiSurrender: state.isAiSurrender,
      idiomChain: state.chain.map((e) => e.word).join(','),
    );

    // 添加星星到积分账户
    if (breakdown.totalStars > 0) {
      // 获取或创建成语接龙规则
      int? ruleId;
      const ruleName = '成语接龙';
      
      try {
        final existingRule = await _rulesRepository.getRuleByName(ruleName);
        if (existingRule != null) {
          ruleId = existingRule.id;
        } else {
          // 创建新规则
          ruleId = await _rulesRepository.createRule(
            name: ruleName,
            type: 'reward',
            points: 1, // 默认单次积分，实际由游戏逻辑决定总分
            icon: 'school', // 默认图标
          );
        }
      } catch (e) {
        logger.error('IdiomGameProvider', '获取或创建规则失败: $e');
        // 即使失败也继续记录积分，只是没有关联规则ID
      }

      await _pointsRepository.addRecord(
        childId: _childId,
        points: breakdown.totalStars,
        type: 'earned',
        ruleId: ruleId,
        ruleName: ruleName,
        note: '${isWin ? "获胜" : "挑战"}，接龙${state.chain.length}个成语',
      );
      logger.info('IdiomGameProvider', '添加积分: ${breakdown.totalStars} 星星');
    }

    // 如果玩家获胜，清除失败记录
    if (isWin) {
      _gameService.clearFailedLastChars(_childId);
    }

    state = state.copyWith(
      status: GameStatus.gameOver,
      starsEarned: breakdown.totalStars,
      scoreBreakdown: breakdown,
    );
  }

  // ... (existing code omitted)
}

// Provider
final idiomGameProvider = StateNotifierProvider.autoDispose.family<IdiomGameNotifier, IdiomGameState, int>(
  (ref, childId) {
    final gameService = ref.watch(idiomGameServiceProvider);
    final pointsRepository = ref.watch(pointRecordsRepositoryProvider);
    final rulesRepository = ref.watch(rulesRepositoryProvider);
    return IdiomGameNotifier(gameService, pointsRepository, rulesRepository, childId);
  },
);
