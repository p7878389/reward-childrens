import 'dart:math';
import 'package:children_rewards/core/utils/result.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart' as domain;
import 'package:children_rewards/features/idiom_game/domain/services/idiom_game_service.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_dao.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_game_settings_dao.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_failure_records_dao.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_game_records_dao.dart';
import 'package:children_rewards/features/idiom_game/services/idiom_data_importer.dart';
import 'package:children_rewards/features/idiom_game/services/fuzzy_idiom_matcher.dart';
import 'package:characters/characters.dart';
import 'package:children_rewards/core/logging/app_logger.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_engagement_dao.dart';

class IdiomGameServiceImpl implements IdiomGameService {
  static const String _tag = 'IdiomGame';
  final IdiomDao _idiomDao;
  final IdiomGameSettingsDao _settingsDao;
  final IdiomGameRecordsDao _recordsDao;
  final IdiomFailureRecordsDao _failureRecordsDao;
  final IdiomEngagementDao _engagementDao;
  final IdiomDataImporter _importer;
  late final FuzzyIdiomMatcher _fuzzyMatcher;

  IdiomGameServiceImpl(this._idiomDao, this._settingsDao, this._recordsDao, this._failureRecordsDao, this._engagementDao, this._importer) {
    _fuzzyMatcher = FuzzyIdiomMatcher(_idiomDao);
  }

  @override
  Future<domain.GameConfig> loadGameConfig(int childId) async {
    final settings = await _settingsDao.getSettings(childId);
    return domain.GameConfig(
      difficulty: domain.Difficulty.normal,
      countdownSeconds: settings?.customCountdown ?? 15,
      freeHintsCount: settings?.customFreeHints ?? 1,
      matchMode: domain.IdiomMatchMode.fromValue(settings?.matchMode ?? 0),
      includeRareIdioms: settings?.includeRareIdioms ?? false,
    );
  }

  @override
  Future<void> saveGameConfig(int childId, domain.GameConfig config) async {
    // Implement save logic if needed
  }

  @override
  Future<Result<domain.IdiomChainLink>> startGame(
    int grade, {
    bool includeRare = false,
    List<String> failedLastChars = const [],
    List<String> usedWords = const [],
  }) async {
    try {
      logger.info(_tag, "startGame: 开始游戏 grade=$grade, includeRare=$includeRare, failedLastChars=$failedLastChars");

      final hasData = await _importer.importIfNeeded();
      logger.info(_tag, "startGame: 数据导入检查 hasData=$hasData");

      if (!hasData) {
        return Result.failure("成语库未就绪，请前往设置页面下载资源");
      }

      // 使用可接龙的开局成语，优先从失败尾字中选择
      final idiom = await _idiomDao.getPlayableStartIdiom(
        grade: grade,
        includeRare: includeRare,
        preferredLastChars: failedLastChars,
        excludeWords: usedWords,
        maxAttempts: 10,
      );

      if (idiom != null) {
        logger.info(_tag, "startGame: 选择成语=\"${idiom.word}\", 尾字=\"${idiom.lastChar}\", 是否来自失败尾字=${failedLastChars.contains(idiom.firstChar)}");

        return Result.success(domain.IdiomChainLink(
          idiomId: idiom.id,
          word: idiom.word,
          pinyin: idiom.pinyin,
          lastPinyin: idiom.lastPinyin,
          explanation: idiom.explanation,
          source: idiom.source,
          player: domain.PlayerType.ai,
          isRare: idiom.isRare,
        ));
      }
      return Result.failure("无法加载成语库，请重试");
    } catch (e, stack) {
      logger.error(_tag, "startGame: 异常 $e", stack);
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<domain.IdiomValidationResult>> validatePlayerIdiom(
    String idiom,
    domain.IdiomChainLink lastLink,
    {domain.IdiomMatchMode matchMode = domain.IdiomMatchMode.exact,
    List<String> usedWords = const []}
  ) async {
    try {
      logger.info(_tag, 'validatePlayerIdiom: idiom="$idiom", lastWord="${lastLink.word}", matchMode=$matchMode, usedWords=${usedWords.length}');

      // 使用缓存的模糊匹配器
      final matchResult = await _fuzzyMatcher.fuzzyFind(idiom);

      if (!matchResult.isMatch || matchResult.idiom == null) {
        logger.warning(
          _tag,
          'validatePlayerIdiom: 成语不存在或匹配度过低 "$idiom" (${matchResult.matchType}, 置信度: ${matchResult.confidence})',
        );
        return Result.success(domain.IdiomValidationResult.invalid(
          domain.IdiomValidationResultType.invalidIdiom,
          matchResult.confidence > 0.5 ? "识别不太清楚，再试一次？" : "这不是一个有效的成语",
        ));
      }

      final matchedIdiom = matchResult.idiom!;

      // 检查是否重复使用
      if (usedWords.contains(matchedIdiom.word)) {
        logger.warning(_tag, 'validatePlayerIdiom: 成语已使用过 "${matchedIdiom.word}"');
        return Result.success(domain.IdiomValidationResult.invalid(
          domain.IdiomValidationResultType.invalidIdiom,
          "这个成语已经用过了，换一个吧！",
        ));
      }
      logger.info(
        _tag,
        'validatePlayerIdiom: 匹配成功 "${matchedIdiom.word}" (${matchResult.matchType}, 置信度: ${matchResult.confidence})',
      );

      final lastChar = lastLink.word.characters.last;
      bool isValid = false;
      String errorMessage = '';

      // 根据匹配模式验证
      switch (matchMode) {
        case domain.IdiomMatchMode.exact:
          // 正常接龙：首字必须等于尾字
          isValid = matchedIdiom.firstChar == lastChar;
          errorMessage = "首字必须是 '$lastChar'";
          break;
        case domain.IdiomMatchMode.contains:
          // 包含尾字：成语中任意位置包含尾字
          isValid = matchedIdiom.word.contains(lastChar);
          errorMessage = "成语中必须包含 '$lastChar'";
          break;
        case domain.IdiomMatchMode.homophone:
          // 同音接龙：首字拼音（带声调）= 尾字拼音
          final lastPinyin = lastLink.lastPinyin;
          if (lastPinyin.isNotEmpty && matchedIdiom.firstPinyin.isNotEmpty) {
            isValid = matchedIdiom.firstPinyin == lastPinyin;
            errorMessage = "首字发音必须是 '$lastPinyin'";
          } else {
            // 兜底：降级为精确匹配
            isValid = matchedIdiom.firstChar == lastChar;
            errorMessage = "首字必须是 '$lastChar'";
          }
          break;
      }

      if (!isValid) {
        logger.warning(_tag, 'validatePlayerIdiom: 不匹配,$errorMessage');
        return Result.success(domain.IdiomValidationResult.invalid(
          domain.IdiomValidationResultType.connectionMismatch,
          errorMessage
        ));
      }

      logger.info(_tag, 'validatePlayerIdiom: 验证成功 "${matchedIdiom.word}"');
      return Result.success(domain.IdiomValidationResult.valid(
        domain.IdiomChainLink(
          idiomId: matchedIdiom.id,
          word: matchedIdiom.word,
          pinyin: matchedIdiom.pinyin,
          lastPinyin: matchedIdiom.lastPinyin,
          explanation: matchedIdiom.explanation,
          source: matchedIdiom.source,
          player: domain.PlayerType.user,
          isRare: matchedIdiom.isRare,
        )
      ));
    } catch (e, stack) {
      logger.error(_tag, "validatePlayerIdiom: 异常 $e", stack);
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<domain.IdiomChainLink>> getAiReply(
    domain.IdiomChainLink playerLink, {
    bool includeRare = false,
    List<String> failedLastChars = const [],
    int currentChainLength = 0,
    domain.IdiomMatchMode matchMode = domain.IdiomMatchMode.exact,
    List<String> usedWords = const [],
    List<String> avoidLastChars = const [],
  }) async {
    try {
      final lastChar = playerLink.word.characters.last;
      final lastPinyin = playerLink.lastPinyin;
      logger.info(_tag, "getAiReply: 查找成语, lastChar=\"$lastChar\", lastPinyin=\"$lastPinyin\", matchMode=$matchMode, includeRare=$includeRare, failedLastChars=$failedLastChars, currentChainLength=$currentChainLength");

      // 50% 概率尝试选择尾字在失败列表中的成语（让失败成语随机出现在接龙中间）
      final shouldPreferFailed = failedLastChars.isNotEmpty && Random().nextDouble() < 0.5;

      final nextIdioms = await _idiomDao.findNextIdioms(
        lastChar: lastChar,
        lastPinyin: lastPinyin,
        matchMode: matchMode,
        includeRare: includeRare,
        limit: 1,
        preferredLastChars: shouldPreferFailed ? failedLastChars : [],
        currentChainLength: currentChainLength,
        excludeWords: usedWords,
        avoidLastChars: avoidLastChars,
      );

      logger.info(_tag, "getAiReply: 查询结果数量=${nextIdioms.length}, 是否优先失败尾字=$shouldPreferFailed");

      if (nextIdioms.isNotEmpty) {
        final aiIdiom = nextIdioms.first;
        return Result.success(domain.IdiomChainLink(
          idiomId: aiIdiom.id,
          word: aiIdiom.word,
          pinyin: aiIdiom.pinyin,
          lastPinyin: aiIdiom.lastPinyin,
          explanation: aiIdiom.explanation,
          source: aiIdiom.source,
          player: domain.PlayerType.ai,
          isRare: aiIdiom.isRare,
        ));
      }

      logger.info(_tag, "getAiReply: AI认输，没有找到可接龙的成语");
      return Result.failure("AI 认输了！");
    } catch (e, stack) {
      logger.error(_tag, "getAiReply: 异常 $e", stack);
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<String>>> getHint(
    domain.IdiomChainLink lastLink,
    int hintsLeft,
    int currentStars,
    {bool includeRare = false, domain.IdiomMatchMode matchMode = domain.IdiomMatchMode.exact}
  ) async {
    if (hintsLeft <= 0 && currentStars < 1) {
      logger.info(_tag, "getHint: 提示次数不足 hintsLeft=$hintsLeft, currentStars=$currentStars");
      return Result.failure("提示次数不足");
    }

    try {
      final lastChar = lastLink.word.characters.last;
      final lastPinyin = lastLink.lastPinyin;
      logger.info(_tag, "getHint: 查找成语, lastChar=\"$lastChar\", lastPinyin=\"$lastPinyin\", matchMode=$matchMode, includeRare=$includeRare");

      final nextIdioms = await _idiomDao.findNextIdioms(
        lastChar: lastChar,
        lastPinyin: lastPinyin,
        matchMode: matchMode,
        includeRare: includeRare,
        limit: 3,
      );

      logger.info(_tag, "getHint: 查询结果数量=${nextIdioms.length}");

      if (nextIdioms.isNotEmpty) {
        final hints = nextIdioms.map((e) => e.word).cast<String>().toList();
        logger.info(_tag, "getHint: 找到提示=$hints");
        return Result.success(hints);
      }

      // 额外诊断：检查数据库中是否有数据
      final totalCount = await _idiomDao.count(includeRare: includeRare);
      logger.warning(_tag, "getHint: 没有找到提示! 数据库总成语数=$totalCount, 查询条件: lastChar=\"$lastChar\", matchMode=$matchMode");

      return Result.failure("没有可用的提示");
    } catch (e, stack) {
      logger.error(_tag, "getHint: 异常 $e", stack);
      return Result.failure(e.toString());
    }
  }

  @override
  Future<bool> hasAvailableIdioms(
    domain.IdiomChainLink lastLink, {
    List<String> usedWords = const [],
    bool includeRare = false,
    domain.IdiomMatchMode matchMode = domain.IdiomMatchMode.exact,
  }) async {
    try {
      final lastChar = lastLink.word.characters.last;
      final lastPinyin = lastLink.lastPinyin;

      // 使用优化的 hasNextIdiom 方法（只查 1 条）
      final hasAvailable = await _idiomDao.hasNextIdiom(
        lastChar: lastChar,
        lastPinyin: lastPinyin,
        matchMode: matchMode,
        includeRare: includeRare,
        excludeWords: usedWords,
      );

      logger.info(_tag, "hasAvailableIdioms: lastChar=\"$lastChar\", usedWords=${usedWords.length}, hasAvailable=$hasAvailable");
      return hasAvailable;
    } catch (e, stack) {
      logger.error(_tag, "hasAvailableIdioms: 异常 $e", stack);
      return false;
    }
  }

  @override
  Future<List<domain.Idiom>> getCandidateIdioms(
    String lastChar,
    {bool includeRare = false, domain.IdiomMatchMode matchMode = domain.IdiomMatchMode.exact, String? lastPinyin}
  ) async {
    try {
      final driftIdioms = await _idiomDao.findNextIdioms(
        lastChar: lastChar,
        lastPinyin: lastPinyin ?? '',
        matchMode: matchMode,
        includeRare: includeRare,
        limit: 100, // 获取较多数量以供展示
      );

      return driftIdioms.map((e) => domain.Idiom(
        id: e.id,
        word: e.word,
        pinyin: e.pinyin,
        firstPinyinNoTone: e.firstPinyinNoTone,
        lastPinyinNoTone: e.lastPinyinNoTone,
        firstPinyin: e.firstPinyin,
        lastPinyin: e.lastPinyin,
        firstChar: e.firstChar,
        lastChar: e.lastChar,
        explanation: e.explanation,
        source: e.source,
        isRare: e.isRare,
      )).toList();
    } catch (e, stack) {
      logger.error(_tag, "getCandidateIdioms: 异常 $e", stack);
      return [];
    }
  }

  @override
  domain.ScoreBreakdown calculateStars({
    required int chainLength,
    required int grade,
    required int hintsUsed,
    required int fastAnswerCount,
    required int playerTurns,
    required int rareIdiomCount,
    required bool isAiSurrender,
    required int timeoutWarningCount,
  }) {
    // 玩家未成功接龙，不给星星
    if (playerTurns <= 0) {
      return domain.ScoreBreakdown(
        totalStars: 0,
        baseStars: 0,
        gradeMultiplier: 1.0,
        speedBonus: 0,
        hintImpact: 0,
        aiSurrenderBonus: 0,
        rareIdiomBonus: 0,
      );
    }

    // 3.1 基础星星
    int baseStars = 0;
    if (chainLength >= 20) {
      baseStars = 8;
    } else if (chainLength >= 15) {
      baseStars = 5;
    } else if (chainLength >= 10) {
      baseStars = 3;
    } else if (chainLength >= 6) {
      baseStars = 2;
    } else if (chainLength >= 3) {
      baseStars = 1;
    }

    // 3.2 年级系数
    double multiplier = 1.0;
    if (grade >= 10) {
      multiplier = 2.5;
    } else if (grade >= 7) {
      multiplier = 2.0;
    } else if (grade >= 5) {
      multiplier = 1.5;
    } else if (grade >= 3) {
      multiplier = 1.2;
    }

    // 3.3 表现奖励
    // 速度奖励: 每 3 次"闪电回答"（<3秒）额外奖励 1 ⭐
    int speedBonus = (fastAnswerCount / 3).floor();

    // 提示惩罚/奖励
    int hintImpact = 0;
    if (hintsUsed == 0) {
      hintImpact = 1; // 完美奖励
    } else if (hintsUsed == 2) {
      hintImpact = -1;
    } else if (hintsUsed >= 3) {
      hintImpact = -2;
    }

    // 3.4 特殊成就奖励
    int achievementBonus = 0;
    int aiSurrenderBonus = 0;
    int rareIdiomBonus = 0;

    if (isAiSurrender) {
      aiSurrenderBonus = 5;
    }
    if (rareIdiomCount >= 3) {
      rareIdiomBonus = 3;
    }
    achievementBonus = aiSurrenderBonus + rareIdiomBonus;

    final finalStars = (baseStars * multiplier) + speedBonus + hintImpact + achievementBonus;
    final totalStars = max(0, finalStars.round());

    return domain.ScoreBreakdown(
      totalStars: totalStars,
      baseStars: baseStars,
      gradeMultiplier: multiplier,
      speedBonus: speedBonus,
      hintImpact: hintImpact,
      aiSurrenderBonus: aiSurrenderBonus,
      rareIdiomBonus: rareIdiomBonus,
    );
  }

  @override
  Future<void> saveGameRecord({
    required int childId,
    required int grade,
    required int chainLength,
    required int starsEarned,
    required int duration,
    required int hintsUsed,
    required int fastAnswerCount,
    required int playerTurns,
    required int rareIdiomCount,
    required int timeoutWarningCount,
    required bool isAiSurrender,
    required String idiomChain,
  }) async {
    // 计算星级评价 (用于关卡解锁)
    int starRating = 0;
    if (chainLength >= 10 || isAiSurrender) {
      starRating = 3;
    } else if (chainLength >= 6) {
      starRating = 2;
    } else if (chainLength >= 3) {
      starRating = 1;
    }

    await _recordsDao.saveRecord(
      childId: childId,
      grade: grade,
      score: chainLength * 10,
      chainLength: chainLength,
      duration: duration,
      starsEarned: starsEarned,
      hintsUsed: hintsUsed,
      fastAnswerCount: fastAnswerCount,
      rareIdiomCount: rareIdiomCount,
      playerTurns: playerTurns,
      timeoutWarningCount: timeoutWarningCount,
      isAiSurrender: isAiSurrender,
      idiomChain: idiomChain,
      starRating: starRating,
    );
  }

  @override
  Future<domain.Idiom?> getFailureCompensation(
    domain.IdiomChainLink lastLink,
    {bool includeRare = false, domain.IdiomMatchMode matchMode = domain.IdiomMatchMode.exact}
  ) async {
    try {
      final nextIdioms = await _idiomDao.findNextIdioms(
        lastChar: lastLink.word.characters.last,
        lastPinyin: lastLink.lastPinyin,
        matchMode: matchMode,
        includeRare: includeRare,
        limit: 1,
      );
      if (nextIdioms.isNotEmpty) {
        final dbIdiom = nextIdioms.first;
        return domain.Idiom(
          id: dbIdiom.id,
          word: dbIdiom.word,
          pinyin: dbIdiom.pinyin,
          firstPinyinNoTone: dbIdiom.firstPinyinNoTone,
          lastPinyinNoTone: dbIdiom.lastPinyinNoTone,
          firstPinyin: dbIdiom.firstPinyin,
          lastPinyin: dbIdiom.lastPinyin,
          firstChar: dbIdiom.firstChar,
          lastChar: dbIdiom.lastChar,
          explanation: dbIdiom.explanation,
          source: dbIdiom.source,
          isRare: dbIdiom.isRare,
        );
      }
      return null;
    } catch (e, stack) {
      logger.error(_tag, "getFailureCompensation: 异常 $e", stack);
      return null;
    }
  }

  @override
  Future<void> recordFailedLastChar(int childId, String lastChar) async {
    logger.info(_tag, "recordFailedLastChar: childId=$childId, lastChar=$lastChar");
    await _failureRecordsDao.recordFailure(childId, lastChar);
  }

  @override
  Future<List<String>> getFailedLastChars(int childId) async {
    return _failureRecordsDao.getFailedLastChars(childId);
  }

  @override
  Future<void> clearFailedLastChars(int childId) async {
    await _failureRecordsDao.clearAll(childId);
    logger.info(_tag, "clearFailedLastChars: childId=$childId");
  }

  @override
  Future<void> recordSuccessLastChar(int childId, String lastChar) async {
    logger.info(_tag, "recordSuccessLastChar: childId=$childId, lastChar=$lastChar");
    await _failureRecordsDao.recordSuccess(childId, lastChar);
  }

  @override
  Future<void> recordEngagement(int childId, int idiomId, {required bool isCorrect}) {
    return _engagementDao.upsertEngagement(childId, idiomId, isCorrect: isCorrect);
  }
}