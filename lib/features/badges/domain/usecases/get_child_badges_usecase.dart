import 'package:children_rewards/core/usecases/result.dart';
import 'package:children_rewards/core/usecases/usecase.dart';
import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/domain/entities/badge_acquisition_entity.dart';
import 'package:children_rewards/features/badges/domain/repositories/i_badge_repository.dart';
import 'package:children_rewards/features/badges/domain/repositories/i_badge_acquisition_repository.dart';
import 'package:children_rewards/features/badges/domain/evaluators/badge_evaluator_factory.dart';

class ChildBadgeDisplay {
  final BadgeEntity badge;
  final BadgeAcquisitionEntity? acquisition;
  final double progress;
  final int currentValue;

  const ChildBadgeDisplay({
    required this.badge,
    this.acquisition,
    required this.progress,
    required this.currentValue,
  });

  bool get isAcquired => acquisition != null;
}

class GetChildBadgesParams {
  final int childId;
  final bool acquiredOnly;
  const GetChildBadgesParams({
    required this.childId,
    this.acquiredOnly = false,
  });
}

class GetChildBadgesUseCase extends UseCase<GetChildBadgesParams, List<ChildBadgeDisplay>> {
  final IBadgeRepository _badgeRepository;
  final IBadgeAcquisitionRepository _acquisitionRepository;
  final BadgeEvaluatorFactory _evaluatorFactory;

  GetChildBadgesUseCase(
    this._badgeRepository,
    this._acquisitionRepository,
    this._evaluatorFactory,
  );

  @override
  Future<Result<List<ChildBadgeDisplay>>> execute(GetChildBadgesParams params) async {
    try {
      final allBadges = await _badgeRepository.getActiveBadges();
      final acquisitions = await _acquisitionRepository.getChildAcquisitions(params.childId);
      final acqMap = {for (var a in acquisitions) a.badgeId: a};

      final List<ChildBadgeDisplay> displayList = [];

      for (final badge in allBadges) {
        final acquisition = acqMap[badge.id];
        if (params.acquiredOnly && acquisition == null) continue;

        double progress = 1.0;
        int currentValue = badge.triggerThreshold;

        if (acquisition == null) {
          final evaluator = _evaluatorFactory.getEvaluator(badge.triggerType);
          if (evaluator != null) {
            final evalResult = await evaluator.evaluate(params.childId, badge);
            progress = evalResult.progress;
            currentValue = evalResult.currentValue;
          } else {
            progress = 0.0;
            currentValue = 0;
          }
        } else {
          currentValue = acquisition.triggerValue ?? badge.triggerThreshold;
        }

        displayList.add(ChildBadgeDisplay(
          badge: badge,
          acquisition: acquisition,
          progress: progress,
          currentValue: currentValue,
        ));
      }

      // 排序：已获得的在前，然后按 sortOrder
      displayList.sort((a, b) {
        if (a.isAcquired != b.isAcquired) {
          return a.isAcquired ? -1 : 1;
        }
        return a.badge.sortOrder.compareTo(b.badge.sortOrder);
      });

      return Result.success(displayList);
    } catch (e, stackTrace) {
      return Result.failure('获取徽章列表失败', exception: e as Exception, stackTrace: stackTrace);
    }
  }
}
