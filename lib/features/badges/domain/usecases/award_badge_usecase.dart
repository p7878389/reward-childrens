import 'dart:convert';
import 'package:children_rewards/core/usecases/result.dart';
import 'package:children_rewards/core/usecases/usecase.dart';
import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/domain/repositories/i_badge_acquisition_repository.dart';
import 'package:children_rewards/features/points/domain/repositories/i_point_records_repository.dart';

class AwardBadgeParams {
  final int childId;
  final BadgeEntity badge;
  final int triggerValue;
  final String? note;
  const AwardBadgeParams({
    required this.childId,
    required this.badge,
    required this.triggerValue,
    this.note,
  });
}

class AwardBadgeUseCase extends UseCase<AwardBadgeParams, void> {
  final IBadgeAcquisitionRepository _acquisitionRepository;
  final IPointRecordsRepository _pointRecordsRepository;

  AwardBadgeUseCase(
    this._acquisitionRepository,
    this._pointRecordsRepository,
  );

  @override
  Future<Result<void>> execute(AwardBadgeParams params) async {
    try {
      int? pointRecordId;

      // 1. 如有奖励积分，先创建积分记录
      if (params.badge.bonusPoints > 0) {
        pointRecordId = await _pointRecordsRepository.addRecordAndReturnId(
          childId: params.childId,
          points: params.badge.bonusPoints,
          type: 'earned',
          ruleName: '徽章奖励：${params.badge.name}',
          note: '获得徽章【${params.badge.name}】的奖励积分',
        );
      }

      // 2. 创建徽章获得记录
      await _acquisitionRepository.create(
        childId: params.childId,
        badgeId: params.badge.id,
        badgeSnapshot: jsonEncode({
          'name': params.badge.name,
          'icon': params.badge.icon,
          'level': params.badge.level,
        }),
        bonusPointsAwarded: params.badge.bonusPoints,
        pointRecordId: pointRecordId,
        triggerValue: params.triggerValue,
        note: params.note,
      );

      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure('授予徽章失败', exception: e as Exception, stackTrace: stackTrace);
    }
  }
}
