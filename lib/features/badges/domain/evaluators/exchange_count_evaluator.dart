import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/domain/evaluators/badge_condition_evaluator.dart';
import 'package:children_rewards/features/exchange/domain/repositories/i_exchange_repository.dart';

// 兑换次数评估器
class ExchangeCountEvaluator implements IBadgeConditionEvaluator {
  final IExchangeRepository _exchangeRepository;

  ExchangeCountEvaluator(this._exchangeRepository);

  @override
  BadgeTriggerType get supportedType => BadgeTriggerType.exchangeCount;

  @override
  Future<BadgeEvaluationResult> evaluate(int childId, BadgeEntity badge) async {
    final exchangeCount = await _exchangeRepository.getExchangeCount(childId);
    return BadgeEvaluationResult(
      isSatisfied: exchangeCount >= badge.triggerThreshold,
      currentValue: exchangeCount,
      targetThreshold: badge.triggerThreshold,
    );
  }
}
