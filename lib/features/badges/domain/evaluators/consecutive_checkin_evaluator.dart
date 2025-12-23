import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/domain/evaluators/badge_condition_evaluator.dart';
import 'package:children_rewards/features/badges/domain/repositories/i_checkin_repository.dart';

// 连续签到评估器
class ConsecutiveCheckinEvaluator implements IBadgeConditionEvaluator {
  final ICheckinRepository _checkinRepository;

  ConsecutiveCheckinEvaluator(this._checkinRepository);

  @override
  BadgeTriggerType get supportedType => BadgeTriggerType.consecutiveCheckin;

  @override
  Future<BadgeEvaluationResult> evaluate(int childId, BadgeEntity badge) async {
    final currentStreak = await _checkinRepository.getCurrentStreak(childId);
    return BadgeEvaluationResult(
      isSatisfied: currentStreak >= badge.triggerThreshold,
      currentValue: currentStreak,
      targetThreshold: badge.triggerThreshold,
    );
  }
}
