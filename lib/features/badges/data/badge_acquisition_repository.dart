import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/features/badges/domain/entities/badge_acquisition_entity.dart';
import 'package:children_rewards/features/badges/domain/repositories/i_badge_acquisition_repository.dart';

class BadgeAcquisitionRepository implements IBadgeAcquisitionRepository {
  final AppDatabase _db;

  BadgeAcquisitionRepository(this._db);

  @override
  Future<List<BadgeAcquisitionEntity>> getChildAcquisitions(int childId) async {
    final rows = await (_db.select(_db.badgeAcquisitions)
          ..where((t) => t.childId.equals(childId) & t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)]))
        .get();

    return rows.map((row) => _mapToEntity(row)).toList();
  }

  @override
  Future<Set<int>> getAcquiredBadgeIds(int childId) async {
    final query = _db.selectOnly(_db.badgeAcquisitions)
      ..addColumns([_db.badgeAcquisitions.badgeId])
      ..where(_db.badgeAcquisitions.childId.equals(childId) & _db.badgeAcquisitions.isDeleted.equals(false));

    final rows = await query.get();
    return rows.map((row) => row.read(_db.badgeAcquisitions.badgeId)!).toSet();
  }

  @override
  Future<int> create({
    required int childId,
    required int badgeId,
    required String badgeSnapshot,
    required int bonusPointsAwarded,
    int? pointRecordId,
    int? triggerValue,
    String? note,
  }) {
    return _db.into(_db.badgeAcquisitions).insert(BadgeAcquisitionsCompanion.insert(
          childId: childId,
          badgeId: badgeId,
          badgeSnapshot: badgeSnapshot,
          bonusPointsAwarded: bonusPointsAwarded,
          pointRecordId: Value(pointRecordId),
          triggerValue: Value(triggerValue),
          note: Value(note),
          createdAt: DateTime.now(),
        ));
  }

  BadgeAcquisitionEntity _mapToEntity(BadgeAcquisition row) {
    return BadgeAcquisitionEntity(
      id: row.id,
      childId: row.childId,
      badgeId: row.badgeId,
      badgeSnapshot: row.badgeSnapshot,
      bonusPointsAwarded: row.bonusPointsAwarded,
      pointRecordId: row.pointRecordId,
      triggerValue: row.triggerValue,
      note: row.note,
      isDeleted: row.isDeleted,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
