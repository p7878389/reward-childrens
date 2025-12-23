import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/domain/evaluators/badge_condition_evaluator.dart';

class BadgeEvaluatorFactory {
  final Map<BadgeTriggerType, IBadgeConditionEvaluator> _evaluators = {};

  void register(IBadgeConditionEvaluator evaluator) {
    _evaluators[evaluator.supportedType] = evaluator;
  }

  IBadgeConditionEvaluator? getEvaluator(BadgeTriggerType type) {
    return _evaluators[type];
  }

  bool supports(BadgeTriggerType type) => _evaluators.containsKey(type);
}
