import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart' as entities;
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_puzzle_entities.dart';

abstract class IdiomPuzzleService {
  /// 生成成语补全题目
  Future<List<CompletionPuzzle>> generateCompletionPuzzles({
    required int grade,
    required int count,
    required int hiddenCount,
    required int childId,
    bool isReviewMode = false,
  });

  /// 生成看意思猜成语题目（选择题）
  Future<List<MeaningPuzzle>> generateMeaningPuzzles({
    required int grade,
    required int count,
    int optionCount = 4,
    int? childId, // Need childId for review mode
    bool isReviewMode = false,
  });

  /// 验证补全答案
  Future<PuzzleResult> validateCompletionAnswer(String answer, entities.Idiom target, int timeTaken);

  /// 验证选择题答案
  PuzzleResult validateMeaningAnswer(int selectedIndex, MeaningPuzzle puzzle, int timeTaken);

  /// 计算星星
  int calculateStars({
    required int correctCount,
    required int totalCount,
    required int hintsUsed,
    required int skippedCount, // New parameter
    required int avgTimeSeconds,
    required int grade,
  });

  /// 保存游戏记录
  Future<void> saveRecord({
    required int childId,
    required IdiomGameMode mode,
    required int grade,
    required int correctCount,
    required int totalCount,
    required int starsEarned,
    required int timeTakenSeconds,
  });

  /// 检查数据健康度
  Future<int> checkDataHealth(int grade, {bool requireExplanation = false});
  
  /// 获取互动记录
  Future<dynamic> getEngagementRecord(int childId, int idiomId);

  /// 记录互动
  Future<void> recordEngagement(int childId, int idiomId, {required bool isCorrect});
}
