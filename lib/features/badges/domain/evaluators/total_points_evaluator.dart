import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/domain/evaluators/badge_condition_evaluator.dart';
import 'package:children_rewards/features/points/domain/repositories/i_point_records_repository.dart';

// 累计积分评估器
class TotalPointsEvaluator implements IBadgeConditionEvaluator {
  final IPointRecordsRepository _pointRecordsRepository;

  TotalPointsEvaluator(this._pointRecordsRepository);

  @override
  BadgeTriggerType get supportedType => BadgeTriggerType.totalPoints;

  @override
  Future<BadgeEvaluationResult> evaluate(int childId, BadgeEntity badge) async {
    final stats = await _pointRecordsRepository.getStats(childId);
    final totalEarned = stats['earned'] ?? 0;
    return BadgeEvaluationResult(
      isSatisfied: totalEarned >= badge.triggerThreshold,
      currentValue: totalEarned,
      targetThreshold: badge.triggerThreshold,
    );
  }
}
