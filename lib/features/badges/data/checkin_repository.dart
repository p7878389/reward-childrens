import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/features/badges/domain/entities/checkin_entity.dart';
import 'package:children_rewards/features/badges/domain/repositories/i_checkin_repository.dart';

class CheckinRepository implements ICheckinRepository {
  final AppDatabase _db;

  CheckinRepository(this._db);

  @override
  Future<int> getCurrentStreak(int childId) async {
    final lastCheckin = await getLastCheckin(childId);
    if (lastCheckin == null) return 0;

    // 检查最后一次签到是否在昨天或今天
    final today = DateTime.now();
    final lastDate = DateTime.parse(lastCheckin.checkinDate);
    final difference = today.difference(lastDate).inDays;

    if (difference <= 1) {
      return lastCheckin.streakDays;
    } else {
      return 0;
    }
  }

  @override
  Future<int> addCheckin({
    required int childId,
    required String checkinDate,
    required int streakDays,
    int? pointRecordId,
  }) {
    return _db.into(_db.checkinRecords).insert(CheckinRecordsCompanion.insert(
          childId: childId,
          checkinDate: checkinDate,
          streakDays: streakDays,
          pointRecordId: Value(pointRecordId),
          createdAt: DateTime.now(),
        ));
  }

  @override
  Future<CheckinEntity?> getLastCheckin(int childId) async {
    final row = await (_db.select(_db.checkinRecords)
          ..where((t) => t.childId.equals(childId) & t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.checkinDate, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();

    return row != null ? _mapToEntity(row) : null;
  }

  CheckinEntity _mapToEntity(CheckinRecord row) {
    return CheckinEntity(
      id: row.id,
      childId: row.childId,
      checkinDate: row.checkinDate,
      streakDays: row.streakDays,
      pointRecordId: row.pointRecordId,
      isDeleted: row.isDeleted,
      createdAt: row.createdAt,
    );
  }
}
