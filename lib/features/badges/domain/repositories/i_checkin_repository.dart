import 'package:children_rewards/features/badges/domain/entities/checkin_entity.dart';

abstract class ICheckinRepository {
  Future<int> getCurrentStreak(int childId);
  Future<int> addCheckin({
    required int childId,
    required String checkinDate,
    required int streakDays,
    int? pointRecordId,
  });
  Future<CheckinEntity?> getLastCheckin(int childId);
}
