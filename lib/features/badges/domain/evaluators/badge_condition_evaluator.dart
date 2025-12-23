import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';

/// 徽章条件评估结果
class BadgeEvaluationResult {
  final bool isSatisfied; // 是否满足条件
  final int currentValue; // 当前进度值
  final int targetThreshold; // 目标阈值

  double get progress =>
      targetThreshold > 0 ? (currentValue / targetThreshold).clamp(0.0, 1.0) : 0.0;

  const BadgeEvaluationResult({
    required this.isSatisfied,
    required this.currentValue,
    required this.targetThreshold,
  });
}

/// 徽章条件评估器抽象接口（策略模式）
abstract class IBadgeConditionEvaluator {
  BadgeTriggerType get supportedType;
  Future<BadgeEvaluationResult> evaluate(int childId, BadgeEntity badge);
}
