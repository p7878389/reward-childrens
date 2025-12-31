import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_puzzle_entities.dart';
import 'package:children_rewards/features/idiom_game/domain/services/idiom_puzzle_service.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart';
import 'package:children_rewards/features/points/data/point_records_repository.dart';
import 'package:children_rewards/features/rule/domain/repositories/i_rules_repository.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_game_settings_dao.dart';

// ---------------- States ----------------

enum PuzzleGameStatus {
  ready,        // 准备就绪，显示开始按钮
  initial,      // 初始状态
  loading,      // 生成题目中
  playing,      // 答题中
  roundResult,  // 单题结果展示 (答对/答错动画)
  finished,     // 整局结束
  error,
}

class IdiomPuzzleState {
  final PuzzleGameStatus status;
  final IdiomGameMode mode;
  final int currentQuestionIndex;
  final int totalQuestions;
  final List<dynamic> puzzles; // CompletionPuzzle or MeaningPuzzle
  final List<PuzzleResult> results;
  final int currentStars; // 本局累计星星
  final bool isReviewMode; // 复习模式不计积分
  
  final int timeLeft;
  final int maxDuration; // Replaces maxTime with dynamic value

  final String? errorMessage;
  final String? currentInput; 
  final int? selectedOptionIndex; 

  final Idiom? idiomToShowDetails;

  const IdiomPuzzleState({
    this.status = PuzzleGameStatus.ready,
    this.mode = IdiomGameMode.completion,
    this.currentQuestionIndex = 0,
    this.totalQuestions = 10,
    this.puzzles = const [],
    this.results = const [],
    this.currentStars = 0,
    this.isReviewMode = false,
    this.timeLeft = 60,
    this.maxDuration = 60,
    this.errorMessage,
    this.currentInput,
    this.selectedOptionIndex,
    this.idiomToShowDetails,
  });

  IdiomPuzzleState copyWith({
    PuzzleGameStatus? status,
    IdiomGameMode? mode,
    int? currentQuestionIndex,
    int? totalQuestions,
    List<dynamic>? puzzles,
    List<PuzzleResult>? results,
    int? currentStars,
    bool? isReviewMode,
    int? timeLeft,
    int? maxDuration,
    String? errorMessage,
    ValueGetter<String?>? currentInput,
    ValueGetter<int?>? selectedOptionIndex,
    ValueGetter<Idiom?>? idiomToShowDetails,
  }) {
    return IdiomPuzzleState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      puzzles: puzzles ?? this.puzzles,
      results: results ?? this.results,
      currentStars: currentStars ?? this.currentStars,
      isReviewMode: isReviewMode ?? this.isReviewMode,
      timeLeft: timeLeft ?? this.timeLeft,
      maxDuration: maxDuration ?? this.maxDuration,
      errorMessage: errorMessage ?? this.errorMessage,
      currentInput: currentInput != null ? currentInput() : this.currentInput,
      selectedOptionIndex: selectedOptionIndex != null ? selectedOptionIndex() : this.selectedOptionIndex,
      idiomToShowDetails: idiomToShowDetails != null ? idiomToShowDetails() : this.idiomToShowDetails,
    );
  }
  
  bool get isCompletionMode => mode == IdiomGameMode.completion;
  bool get isMeaningMode => mode == IdiomGameMode.meaning;
  
  dynamic get currentPuzzle => 
      (puzzles.isNotEmpty && currentQuestionIndex < puzzles.length) 
      ? puzzles[currentQuestionIndex] 
      : null;
}

// ---------------- Notifier ----------------

class IdiomPuzzleNotifier extends StateNotifier<IdiomPuzzleState> {
  final IdiomPuzzleService _service;
  final PointRecordsRepository _pointsRepository;
  final IRulesRepository _rulesRepository;
  final IdiomGameSettingsDao _settingsDao;
  final int _childId;
  
  Timer? _timer;
  DateTime? _questionStartTime;

  IdiomPuzzleNotifier(
    this._service, 
    this._pointsRepository, 
    this._rulesRepository, 
    this._settingsDao,
    this._childId
  ) : super(const IdiomPuzzleState());

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int _getMaxDuration(int grade, bool isReviewMode) {
    if (isReviewMode) return 120; // 2 minutes for review
    if (grade <= 2) return 90;
    if (grade <= 4) return 60;
    if (grade <= 6) return 45;
    return 30; // Challenge mode
  }

  Future<void> startGame({
    required IdiomGameMode mode,
    required int grade,
    int count = 10,
    Difficulty difficulty = Difficulty.normal,
    bool isReviewMode = false,
  }) async {
    try {
      state = state.copyWith(status: PuzzleGameStatus.loading, mode: mode);

      // Fetch settings
      final settings = await _settingsDao.getSettings(_childId);
      final customDuration = settings?.customCountdown;
      // includeRare reserved for future use

      List<dynamic> generatedPuzzles;
      
      if (mode == IdiomGameMode.completion) {
        int hiddenCount = 1;
        if (difficulty == Difficulty.normal) hiddenCount = 2;
        if (difficulty == Difficulty.hard) hiddenCount = 3;
        
        generatedPuzzles = await _service.generateCompletionPuzzles(
          grade: grade, 
          count: count, 
          hiddenCount: hiddenCount,
          childId: _childId,
          isReviewMode: isReviewMode,
        );
      } else {
        generatedPuzzles = await _service.generateMeaningPuzzles(
          grade: grade, 
          count: count,
          childId: _childId,
          isReviewMode: isReviewMode,
        );
      }
      
      if (generatedPuzzles.isEmpty) {
        state = state.copyWith(status: PuzzleGameStatus.error, errorMessage: isReviewMode ? "没有需要复习的成语" : "无法生成题目，请检查资源是否已下载");
        return;
      }

      int maxDuration = _getMaxDuration(grade, isReviewMode);
      
      // Override with custom settings if in Normal Mode
      if (!isReviewMode && customDuration != null && customDuration > 0) {
        maxDuration = customDuration;
      }

      state = state.copyWith(
        status: PuzzleGameStatus.playing,
        puzzles: generatedPuzzles,
        totalQuestions: generatedPuzzles.length,
        currentQuestionIndex: 0,
        results: [],
        currentStars: 0,
        isReviewMode: isReviewMode,
        timeLeft: maxDuration,
        maxDuration: maxDuration,
        currentInput: () => '',
        selectedOptionIndex: () => null,
      );
      
      _startTimer();
      _questionStartTime = DateTime.now();

    } catch (e) {
      state = state.copyWith(status: PuzzleGameStatus.error, errorMessage: e.toString());
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timeLeft > 0) {
        state = state.copyWith(timeLeft: state.timeLeft - 1);
      } else {
        _handleTimeout();
      }
    });
  }
  
  void _stopTimer() {
    _timer?.cancel();
  }

  void _handleTimeout() {
    _stopTimer();
    // Timeout is treated as a skip/wrong
    _skipInternal();
  }

  void skipCurrentQuestion() {
    _stopTimer();
    _skipInternal(isUserAction: true);
  }

  void _skipInternal({bool isUserAction = false}) {
    final puzzle = state.currentPuzzle;
    if (puzzle == null) return;

    int idiomId = 0;
    if (state.isCompletionMode) {
      idiomId = (puzzle as CompletionPuzzle).idiom.id;
    } else {
      idiomId = (puzzle as MeaningPuzzle).correctIdiom.id;
    }

    final result = PuzzleResult(
      isCorrect: false,
      isSkipped: true,
      timeTaken: state.maxDuration - state.timeLeft,
    );

    _handleResult(idiomId, result);
  }

  Future<void> submitCompletionAnswer(String input) async {
    if (state.status != PuzzleGameStatus.playing) return;
    
    _stopTimer();
    final puzzle = state.currentPuzzle as CompletionPuzzle;
    final timeTaken = DateTime.now().difference(_questionStartTime!).inSeconds;
    
    final result = await _service.validateCompletionAnswer(input, puzzle.idiom, timeTaken);
    if (!mounted) return;
    _handleResult(puzzle.idiom.id, result);
  }

  Future<void> submitMeaningAnswer(int selectedIndex) async {
    if (state.status != PuzzleGameStatus.playing) return;
    
    _stopTimer();
    state = state.copyWith(selectedOptionIndex: () => selectedIndex);

    final puzzle = state.currentPuzzle as MeaningPuzzle;
    final timeTaken = DateTime.now().difference(_questionStartTime!).inSeconds;
    
    final result = _service.validateMeaningAnswer(selectedIndex, puzzle, timeTaken);
    
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    _handleResult(puzzle.correctIdiom.id, result);
  }

  void _handleResult(int idiomId, PuzzleResult result) async {
    if (!mounted) return;
    final newResults = [...state.results, result];
    
    // Intermediate star calculation (just for display, final calc is strict)
    int stars = state.currentStars;
    if (result.isCorrect) stars += 1;

    final engagement = await _service.getEngagementRecord(_childId, idiomId);
    if (!mounted) return;
    final encounterCount = engagement != null ? engagement.encounterCount : 0;

    await _service.recordEngagement(_childId, idiomId, isCorrect: result.isCorrect);
    if (!mounted) return;

    Idiom? idiomToShow;
    if (!result.isCorrect || encounterCount == 0 || result.isSkipped) {
      final puzzle = state.currentPuzzle;
      if (puzzle != null) {
        if (state.isCompletionMode) {
          idiomToShow = (puzzle as CompletionPuzzle).idiom;
        } else {
          idiomToShow = (puzzle as MeaningPuzzle).correctIdiom;
        }
      }
    }

    state = state.copyWith(
      status: PuzzleGameStatus.roundResult,
      results: newResults,
      currentStars: stars,
      idiomToShowDetails: () => idiomToShow,
    );

    int delayMs = 1500;
    if (idiomToShow != null) {
      delayMs = 5500; // 5s auto-close + buffer
    }
    await Future.delayed(Duration(milliseconds: delayMs));
    if (!mounted) return;

    if (state.currentQuestionIndex < state.totalQuestions - 1) {
      _nextQuestion();
    } else {
      _finishGame();
    }
  }

  void _nextQuestion() {
    state = state.copyWith(
      status: PuzzleGameStatus.playing,
      currentQuestionIndex: state.currentQuestionIndex + 1,
      timeLeft: state.maxDuration,
      currentInput: () => '',
      selectedOptionIndex: () => null,
      idiomToShowDetails: () => null,
    );
    _questionStartTime = DateTime.now();
    _startTimer();
  }

  Future<void> _finishGame() async {
    state = state.copyWith(status: PuzzleGameStatus.finished);
    
    final correctCount = state.results.where((r) => r.isCorrect).length;
    final skippedCount = state.results.where((r) => r.isSkipped).length;
    final totalCount = state.totalQuestions;
    final totalTime = state.results.fold(0, (sum, r) => sum + r.timeTaken);
    
    int grade = 1;
    if (state.puzzles.isNotEmpty) {
      final first = state.puzzles.first;
      if (first is CompletionPuzzle) {
        grade = first.idiom.gradeLevel;
      } else if (first is MeaningPuzzle) {
        grade = first.correctIdiom.gradeLevel;
      }
    }

    final finalStars = _service.calculateStars(
      correctCount: correctCount, 
      totalCount: totalCount, 
      hintsUsed: 0, 
      skippedCount: skippedCount,
      avgTimeSeconds: totalCount > 0 ? (totalTime / totalCount).round() : 0, 
      grade: grade
    );

    state = state.copyWith(
      status: PuzzleGameStatus.finished,
      currentStars: finalStars, // Sync correctly calculated stars to state
    );

    if (!state.isReviewMode) {
      await _service.saveRecord(
        childId: _childId,
        mode: state.mode,
        grade: grade,
        correctCount: correctCount,
        totalCount: totalCount,
        starsEarned: finalStars,
        timeTakenSeconds: totalTime,
      );
    }

    if (finalStars > 0 && !state.isReviewMode) {
      int? ruleId;
      final String modeName = state.isCompletionMode ? "成语补全" : "看意猜词";
      const ruleName = "成语专项训练";
      
      try {
        final existingRule = await _rulesRepository.getRuleByName(ruleName);
        if (existingRule != null) {
          ruleId = existingRule.id;
        } else {
          ruleId = await _rulesRepository.createRule(
            name: ruleName,
            type: 'reward',
            points: 1,
            icon: 'extension',
          );
        }
      } catch (e) {
        // Silent error
      }

      await _pointsRepository.addRecord(
        childId: _childId,
        points: finalStars,
        type: 'earned',
        ruleId: ruleId,
        ruleName: ruleName,
        note: '$modeName训练，答对$correctCount/$totalCount题 (跳过$skippedCount题)',
      );
    }
  }

  void clearIdiomDetails() {
    state = state.copyWith(idiomToShowDetails: () => null);
  }
}
