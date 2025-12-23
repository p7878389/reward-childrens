import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/domain/evaluators/badge_evaluator_factory.dart';
import 'package:children_rewards/features/badges/domain/evaluators/single_points_evaluator.dart';
import 'package:children_rewards/features/badges/domain/repositories/i_badge_acquisition_repository.dart';
import 'package:children_rewards/features/badges/domain/repositories/i_badge_repository.dart';

class PendingBadgeAward {
  final BadgeEntity badge;
  final int triggerValue;
  const PendingBadgeAward({required this.badge, required this.triggerValue});
}

class BadgeDetectionService {
  final IBadgeRepository _badgeRepository;
  final IBadgeAcquisitionRepository _acquisitionRepository;
  final BadgeEvaluatorFactory _evaluatorFactory;

  BadgeDetectionService(
    this._badgeRepository,
    this._acquisitionRepository,
    this._evaluatorFactory,
  );

  /// 检测孩子可获得的新徽章
  Future<List<PendingBadgeAward>> detectNewBadges(
    int childId, {
    List<BadgeTriggerType>? triggerTypes,
    Map<String, dynamic>? context,
  }) async {
    final pendingAwards = <PendingBadgeAward>[];

    // 1. 获取所有有效徽章
    final allBadges = await _badgeRepository.getActiveBadges();

    // 2. 获取该孩子已获得的徽章ID集合
    final acquiredBadgeIds = await _acquisitionRepository.getAcquiredBadgeIds(childId);

    // 3. 筛选尚未获得且符合触发类型的徽章
    final candidateBadges = allBadges.where((badge) {
      final notAcquired = !acquiredBadgeIds.contains(badge.id);
      final typeMatch = triggerTypes == null || triggerTypes.contains(badge.triggerType);
      return notAcquired && typeMatch;
    }).toList();

    // 4. 设置上下文（如单次积分）
    if (context != null && context.containsKey('singlePoints')) {
      final singleEvaluator = _evaluatorFactory.getEvaluator(BadgeTriggerType.pointsEarnedSingle);
      if (singleEvaluator is SinglePointsEvaluator) {
        singleEvaluator.setContext(singlePoints: context['singlePoints'] as int);
      }
    }

    // 5. 逐个评估
    for (final badge in candidateBadges) {
      final evaluator = _evaluatorFactory.getEvaluator(badge.triggerType);
      if (evaluator == null) continue;

      final result = await evaluator.evaluate(childId, badge);
      if (result.isSatisfied) {
        pendingAwards.add(PendingBadgeAward(
          badge: badge,
          triggerValue: result.currentValue,
        ));
      }
    }

    return pendingAwards;
  }
}
