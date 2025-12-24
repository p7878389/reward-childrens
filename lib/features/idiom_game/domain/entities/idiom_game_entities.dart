enum GameStatus { initializing, ready, starting, playing, roundOver, gameOver, error }
enum Difficulty { easy, normal, hard }
enum PlayerType { user, ai }

/// 成语接龙匹配模式
enum IdiomMatchMode {
  exact(0),       // 正常接龙：首字必须等于上个成语的尾字
  contains(1),    // 包含尾字：成语中任意位置包含尾字即可
  homophone(2);   // 同音接龙：首字拼音（含声调）与尾字拼音相同

  final int value;
  const IdiomMatchMode(this.value);

  /// 从数据库值转换为枚举
  static IdiomMatchMode fromValue(int value) {
    return IdiomMatchMode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => IdiomMatchMode.exact,
    );
  }

  /// 获取模式名称
  String get displayName {
    switch (this) {
      case IdiomMatchMode.exact:
        return '正常接龙';
      case IdiomMatchMode.contains:
        return '包含尾字';
      case IdiomMatchMode.homophone:
        return '同音接龙';
    }
  }

  /// 获取模式描述
  String get description {
    switch (this) {
      case IdiomMatchMode.exact:
        return '首字必须等于上个成语的尾字';
      case IdiomMatchMode.contains:
        return '成语中任意位置包含尾字即可';
      case IdiomMatchMode.homophone:
        return '首字发音（含声调）与尾字相同';
    }
  }

  /// 获取示例
  String get example {
    switch (this) {
      case IdiomMatchMode.exact:
        return '一心一意 → 意气风发';
      case IdiomMatchMode.contains:
        return '一心一意 → 毫无意见';
      case IdiomMatchMode.homophone:
        return '一心一意 → 义无反顾（yì=yì）';
    }
  }
}

class GameConfig {
  final Difficulty difficulty;
  final int countdownSeconds;
  final int freeHintsCount;
  final IdiomMatchMode matchMode;  // 接龙匹配模式
  final bool includeRareIdioms;    // 是否包含生僻成语

  GameConfig({
    required this.difficulty,
    required this.countdownSeconds,
    required this.freeHintsCount,
    required this.matchMode,
    required this.includeRareIdioms,
  });

  factory GameConfig.defaultConfig() {
    return GameConfig(
      difficulty: Difficulty.normal,
      countdownSeconds: 15,
      freeHintsCount: 1,
      matchMode: IdiomMatchMode.exact,
      includeRareIdioms: false,
    );
  }

  GameConfig copyWith({
    Difficulty? difficulty,
    int? countdownSeconds,
    int? freeHintsCount,
    IdiomMatchMode? matchMode,
    bool? includeRareIdioms,
  }) {
    return GameConfig(
      difficulty: difficulty ?? this.difficulty,
      countdownSeconds: countdownSeconds ?? this.countdownSeconds,
      freeHintsCount: freeHintsCount ?? this.freeHintsCount,
      matchMode: matchMode ?? this.matchMode,
      includeRareIdioms: includeRareIdioms ?? this.includeRareIdioms,
    );
  }
}

class IdiomChainLink {
  final int? idiomId; // Link to database ID
  final String word;
  final String pinyin;
  final String lastPinyin;  // 尾字拼音（带声调），用于同音接龙
  final PlayerType player;
  final String? explanation;
  final String? source;
  final bool isRare;

  IdiomChainLink({
    this.idiomId,
    required this.word,
    required this.pinyin,
    this.lastPinyin = '',
    required this.player,
    this.explanation,
    this.source,
    this.isRare = false,
  });
}

class ScoreBreakdown {
  final int totalStars;
  final int baseStars;
  final double gradeMultiplier;
  final int speedBonus;
  final int hintImpact;
  final int aiSurrenderBonus;
  final int rareIdiomBonus;

  ScoreBreakdown({
    required this.totalStars,
    required this.baseStars,
    required this.gradeMultiplier,
    required this.speedBonus,
    required this.hintImpact,
    required this.aiSurrenderBonus,
    required this.rareIdiomBonus,
  });
}

class Idiom {
  final int id;
  final String word;
  final String pinyin;
  final String firstPinyinNoTone;
  final String lastPinyinNoTone;
  final String firstPinyin;   // 首字拼音（带声调）
  final String lastPinyin;    // 尾字拼音（带声调）
  final String firstChar;
  final String lastChar;
  final String? explanation;
  final String? source;
  final bool isRare;
  final int gradeLevel;

  Idiom({
    required this.id,
    required this.word,
    required this.pinyin,
    required this.firstPinyinNoTone,
    required this.lastPinyinNoTone,
    this.firstPinyin = '',
    this.lastPinyin = '',
    required this.firstChar,
    required this.lastChar,
    this.explanation,
    this.source,
    this.isRare = false,
    this.gradeLevel = 1,
  });
}

/// 游戏错误事件

class GameError {

  final String message;

  final DateTime timestamp;



  GameError(this.message) : timestamp = DateTime.now();



  @override

  String toString() => message;

}



enum IdiomValidationResultType {

  valid,

  invalidIdiom,

  connectionMismatch,

  alreadyUsed,

}



class IdiomValidationResult {

  final bool isValid;

  final IdiomValidationResultType type;

  final String? message;

  final IdiomChainLink? link;



  IdiomValidationResult.valid(this.link)

      : isValid = true,

        type = IdiomValidationResultType.valid,

        message = null;



  IdiomValidationResult.invalid(this.type, this.message)

      : isValid = false,

        link = null;

}
