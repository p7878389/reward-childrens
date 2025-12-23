import 'package:children_rewards/core/usecases/result.dart';
import 'package:children_rewards/core/usecases/usecase.dart';
import 'package:children_rewards/features/badges/domain/repositories/i_checkin_repository.dart';
import 'package:children_rewards/features/badges/domain/usecases/check_and_award_badges_usecase.dart';
import 'package:children_rewards/features/points/domain/repositories/i_point_records_repository.dart';

class CheckinParams {
  final int childId;
  final int rewardPoints;
  const CheckinParams({
    required this.childId,
    this.rewardPoints = 5,
  });
}

class CheckinResult {
  final int streakDays;
  final BadgeAwardResult? badgeResult;
  const CheckinResult({
    required this.streakDays,
    this.badgeResult,
  });
}

class CheckinUseCase extends UseCase<CheckinParams, CheckinResult> {
  final ICheckinRepository _checkinRepository;
  final IPointRecordsRepository _pointRecordsRepository;
  final CheckAndAwardBadgesUseCase _checkBadgesUseCase;

  CheckinUseCase(
    this._checkinRepository,
    this._pointRecordsRepository,
    this._checkBadgesUseCase,
  );

  @override
  Future<Result<CheckinResult>> execute(CheckinParams params) async {
    try {
      final today = DateTime.now();
      final dateStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

      // 1. 检查是否今日已签到
      final lastCheckin = await _checkinRepository.getLastCheckin(params.childId);
      if (lastCheckin != null && lastCheckin.checkinDate == dateStr) {
        return Result.failure('今日已签到');
      }

      // 2. 计算连续天数
      int streakDays = 1;
      if (lastCheckin != null) {
        final lastDate = DateTime.parse(lastCheckin.checkinDate);
        final diff = today.difference(lastDate).inDays;
        if (diff == 1) {
          streakDays = lastCheckin.streakDays + 1;
        }
      }

      // 3. 发放签到奖励积分
      int? pointRecordId;
      if (params.rewardPoints > 0) {
        pointRecordId = await _pointRecordsRepository.addRecordAndReturnId(
          childId: params.childId,
          points: params.rewardPoints,
          type: 'earned',
          ruleName: '每日签到',
          note: '第 $streakDays 天签到奖励',
        );
      }

      // 4. 记录签到
      await _checkinRepository.addCheckin(
        childId: params.childId,
        checkinDate: dateStr,
        streakDays: streakDays,
        pointRecordId: pointRecordId,
      );

      // 5. 触发徽章检测
      final checkResult = await _checkBadgesUseCase.execute(
        CheckAndAwardBadgesParams(
          childId: params.childId,
          triggerPoint: BadgeTriggerPoint.afterCheckinCompleted,
        ),
      );

      return Result.success(CheckinResult(
        streakDays: streakDays,
        badgeResult: checkResult.dataOrNull,
      ));
    } catch (e, stackTrace) {
      return Result.failure('签到失败', exception: e as Exception, stackTrace: stackTrace);
    }
  }
}
