import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/domain/repositories/i_badge_repository.dart';

class BadgeRepository implements IBadgeRepository {
  final AppDatabase _db;

  BadgeRepository(this._db);

  @override
  Future<List<BadgeEntity>> getActiveBadges() async {
    final rows = await (_db.select(_db.badges)
          ..where((t) => t.isActive.equals(true) & t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();

    return rows.map((row) => _mapToEntity(row)).toList();
  }

  @override
  Future<List<BadgeEntity>> getAllBadges() async {
    final rows = await (_db.select(_db.badges)
          ..where((t) => t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();

    return rows.map((row) => _mapToEntity(row)).toList();
  }

  @override
  Future<BadgeEntity?> getBadge(int id) async {
    final row = await (_db.select(_db.badges)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row != null ? _mapToEntity(row) : null;
  }

  @override
  Future<int> create(BadgeEntity badge) {
    return _db.into(_db.badges).insert(BadgesCompanion.insert(
          name: badge.name,
          description: Value(badge.description),
          icon: badge.icon,
          level: Value(badge.level),
          triggerType: badge.triggerType.value,
          triggerThreshold: badge.triggerThreshold,
          triggerConfig: Value(badge.triggerConfig != null ? jsonEncode(badge.triggerConfig) : null),
          bonusPoints: Value(badge.bonusPoints),
          sortOrder: Value(badge.sortOrder),
          isActive: Value(badge.isActive),
          isSystem: Value(badge.isSystem),
          createdAt: DateTime.now(),
        ));
  }

  @override
  Future<bool> update(BadgeEntity badge) {
    return _db.update(_db.badges).replace(BadgesCompanion(
          id: Value(badge.id),
          name: Value(badge.name),
          description: Value(badge.description),
          icon: Value(badge.icon),
          level: Value(badge.level),
          triggerType: Value(badge.triggerType.value),
          triggerThreshold: Value(badge.triggerThreshold),
          triggerConfig: Value(badge.triggerConfig != null ? jsonEncode(badge.triggerConfig) : null),
          bonusPoints: Value(badge.bonusPoints),
          sortOrder: Value(badge.sortOrder),
          isActive: Value(badge.isActive),
          isSystem: Value(badge.isSystem),
          createdAt: Value(badge.createdAt),
          updatedAt: Value(DateTime.now()),
        ));
  }

  @override
  Future<bool> delete(int id) async {
    final count = await (_db.update(_db.badges)..where((t) => t.id.equals(id))).write(
      BadgesCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return count > 0;
  }

  BadgeEntity _mapToEntity(Badge row) {
    return BadgeEntity(
      id: row.id,
      name: row.name,
      description: row.description,
      icon: row.icon,
      level: row.level,
      triggerType: BadgeTriggerType.fromString(row.triggerType),
      triggerThreshold: row.triggerThreshold,
      triggerConfig: row.triggerConfig != null ? jsonDecode(row.triggerConfig!) as Map<String, dynamic> : null,
      bonusPoints: row.bonusPoints,
      sortOrder: row.sortOrder,
      isActive: row.isActive,
      isSystem: row.isSystem,
      isDeleted: row.isDeleted,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
