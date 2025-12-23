import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/domain/evaluators/badge_condition_evaluator.dart';

// 单次积分评估器
class SinglePointsEvaluator implements IBadgeConditionEvaluator {
  int? _currentSinglePoints;

  @override
  BadgeTriggerType get supportedType => BadgeTriggerType.pointsEarnedSingle;

  void setContext({required int singlePoints}) {
    _currentSinglePoints = singlePoints;
  }

  @override
  Future<BadgeEvaluationResult> evaluate(int childId, BadgeEntity badge) async {
    final points = _currentSinglePoints ?? 0;
    return BadgeEvaluationResult(
      isSatisfied: points >= badge.triggerThreshold,
      currentValue: points,
      targetThreshold: badge.triggerThreshold,
    );
  }
}
