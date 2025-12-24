import 'package:children_rewards/core/utils/result.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart';

abstract class IdiomGameService {
  Future<GameConfig> loadGameConfig(int childId);
  Future<void> saveGameConfig(int childId, GameConfig config);

  /// 开始游戏（正常随机开局）
  /// [grade] 年级
  /// [includeRare] 是否包含生僻成语
  /// [failedLastChars] 玩家曾失败的尾字列表，优先选择以这些字开头的成语
  /// [usedWords] 本局已出现的成语（避免重复）
  Future<Result<IdiomChainLink>> startGame(
    int grade, {
    bool includeRare = false,
    List<String> failedLastChars = const [],
    List<String> usedWords = const [],
  });

  /// 验证玩家成语
  /// [idiom] 玩家输入的成语
  /// [lastLink] 上一个成语链接
  /// [matchMode] 匹配模式
  /// [usedWords] 本局已出现的成语（避免重复）
  Future<Result<IdiomValidationResult>> validatePlayerIdiom(
    String idiom,
    IdiomChainLink lastLink,
    {IdiomMatchMode matchMode = IdiomMatchMode.exact,
    List<String> usedWords = const []}
  );

  /// AI 回复
  /// [playerLink] 玩家的成语
  /// [includeRare] 是否包含生僻成语
  /// [failedLastChars] 玩家曾失败的尾字列表，AI 会有概率选择以这些字结尾的成语
  /// [currentChainLength] 当前接龙链长度（用于动态调整链长要求）
  /// [matchMode] 匹配模式
  /// [usedWords] 本局已出现的成语（避免重复）
  /// [avoidLastChars] 尽量避免使用的尾字列表
  Future<Result<IdiomChainLink>> getAiReply(
    IdiomChainLink playerLink, {
    bool includeRare = false,
    List<String> failedLastChars = const [],
    int currentChainLength = 0,
    IdiomMatchMode matchMode = IdiomMatchMode.exact,
    List<String> usedWords = const [],
    List<String> avoidLastChars = const [],
  });

  Future<Result<List<String>>> getHint(
    IdiomChainLink lastLink,
    int hintsLeft,
    int currentStars,
    {bool includeRare = false, IdiomMatchMode matchMode = IdiomMatchMode.exact}
  );

  /// 检查是否还有可接的成语
  /// [lastLink] 当前最后一个成语
  /// [usedWords] 本局已出现的成语
  /// [includeRare] 是否包含生僻成语
  /// [matchMode] 匹配模式
  Future<bool> hasAvailableIdioms(
    IdiomChainLink lastLink, {
    List<String> usedWords = const [],
    bool includeRare = false,
    IdiomMatchMode matchMode = IdiomMatchMode.exact,
  });

  /// 获取候选成语列表（用于推荐）
  Future<List<Idiom>> getCandidateIdioms(
    String lastChar,
    {bool includeRare = false, IdiomMatchMode matchMode = IdiomMatchMode.exact, String? lastPinyin}
  );

  ScoreBreakdown calculateStars({
    required int chainLength,
    required int grade,
    required int hintsUsed,
    required int fastAnswerCount,
    required int playerTurns,
    required int rareIdiomCount,
    required bool isAiSurrender,
    required int timeoutWarningCount,
  });

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
  });
  Future<Idiom?> getFailureCompensation(
    IdiomChainLink lastLink,
    {bool includeRare = false, IdiomMatchMode matchMode = IdiomMatchMode.exact}
  );

  /// 记录失败的成语尾字（用于下次出题）
  Future<void> recordFailedLastChar(int childId, String lastChar);

  /// 获取失败的成语尾字列表
  Future<List<String>> getFailedLastChars(int childId);

  /// 清除失败记录
  Future<void> clearFailedLastChars(int childId);

  /// 记录成功接龙的尾字（用于减少失败记录权重）
  Future<void> recordSuccessLastChar(int childId, String lastChar);

  /// 记录互动详情 (SRS)
  Future<void> recordEngagement(int childId, int idiomId, {required bool isCorrect});
}