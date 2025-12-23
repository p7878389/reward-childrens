import 'package:children_rewards/core/usecases/result.dart';
import 'package:children_rewards/core/usecases/usecase.dart';
import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/domain/services/badge_detection_service.dart';
import 'package:children_rewards/features/badges/domain/usecases/award_badge_usecase.dart';

/// 触发点枚举
enum BadgeTriggerPoint {
  afterPointRecordCreated, // 积分记录创建后
  afterExchangeCompleted, // 兑换完成后
  afterCheckinCompleted, // 签到完成后
  manualCheck, // 手动触发检测
}

class CheckAndAwardBadgesParams {
  final int childId;
  final BadgeTriggerPoint triggerPoint;
  final Map<String, dynamic>? context;
  const CheckAndAwardBadgesParams({
    required this.childId,
    required this.triggerPoint,
    this.context,
  });
}

class BadgeAwardResult {
  final List<BadgeEntity> awardedBadges;
  final int totalBonusPoints;
  const BadgeAwardResult({
    required this.awardedBadges,
    required this.totalBonusPoints,
  });
  bool get hasBadges => awardedBadges.isNotEmpty;
}

class CheckAndAwardBadgesUseCase extends UseCase<CheckAndAwardBadgesParams, BadgeAwardResult> {
  final BadgeDetectionService _detectionService;
  final AwardBadgeUseCase _awardBadgeUseCase;

  CheckAndAwardBadgesUseCase(
    this._detectionService,
    this._awardBadgeUseCase,
  );

  @override
  Future<Result<BadgeAwardResult>> execute(CheckAndAwardBadgesParams params) async {
    try {
      // 1. 根据触发点确定要检测的徽章类型
      final triggerTypes = _getTriggerTypesForPoint(params.triggerPoint);

      // 2. 检测可获得的徽章
      final pendingAwards = await _detectionService.detectNewBadges(
        params.childId,
        triggerTypes: triggerTypes,
        context: params.context,
      );

      if (pendingAwards.isEmpty) {
        return Result.success(const BadgeAwardResult(
          awardedBadges: [],
          totalBonusPoints: 0,
        ));
      }

      // 3. 逐个授予徽章
      final awardedBadges = <BadgeEntity>[];
      var totalBonusPoints = 0;

      for (final pending in pendingAwards) {
        final awardResult = await _awardBadgeUseCase.execute(AwardBadgeParams(
          childId: params.childId,
          badge: pending.badge,
          triggerValue: pending.triggerValue,
        ));

        if (awardResult.isSuccess) {
          awardedBadges.add(pending.badge);
          totalBonusPoints += pending.badge.bonusPoints;
        }
      }

      return Result.success(BadgeAwardResult(
        awardedBadges: awardedBadges,
        totalBonusPoints: totalBonusPoints,
      ));
    } catch (e, stackTrace) {
      return Result.failure('徽章检测失败', exception: e as Exception, stackTrace: stackTrace);
    }
  }

  List<BadgeTriggerType>? _getTriggerTypesForPoint(BadgeTriggerPoint point) {
    switch (point) {
      case BadgeTriggerPoint.afterPointRecordCreated:
        return [BadgeTriggerType.totalPoints, BadgeTriggerType.pointsEarnedSingle];
      case BadgeTriggerPoint.afterExchangeCompleted:
        return [BadgeTriggerType.exchangeCount];
      case BadgeTriggerPoint.afterCheckinCompleted:
        return [BadgeTriggerType.consecutiveCheckin];
      case BadgeTriggerPoint.manualCheck:
        return null; // 检测所有类型
    }
  }
}
