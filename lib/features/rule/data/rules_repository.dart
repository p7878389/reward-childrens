import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/features/rule/domain/repositories/i_rules_repository.dart';

/// 规则数据仓库实现
class RulesRepository implements IRulesRepository {
  final AppDatabase _db;

  RulesRepository(this._db);

  @override
  Stream<List<Rule>> watchRulesByType(String type) {
    return (_db.select(_db.rules)
          ..where((t) => t.type.equals(type) & t.isDeleted.equals(false))
          ..orderBy([
            // 先按 isActive 降序（启用的在前）
            (t) => OrderingTerm(expression: t.isActive, mode: OrderingMode.desc),
            // 再按 createdAt 降序（最新的在前）
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  @override
  Future<List<Rule>> getRulesByType(String type) {
    return (_db.select(_db.rules)
          ..where((t) => t.type.equals(type) & t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc)]))
        .get();
  }

  @override
  Future<List<Rule>> getRulesPaged({
    required String type,
    required int limit,
    required int offset,
  }) {
    return (_db.select(_db.rules)
          ..where((t) => t.type.equals(type) & t.isDeleted.equals(false))
          ..orderBy([
            (t) => OrderingTerm(expression: t.isActive, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ])
          ..limit(limit, offset: offset))
        .get();
  }

  @override
  Future<int> getRulesCount(String type) async {
    final query = _db.selectOnly(_db.rules)
      ..addColumns([_db.rules.id.count()])
      ..where(_db.rules.type.equals(type) & _db.rules.isDeleted.equals(false));
    final result = await query.getSingle();
    return result.read(_db.rules.id.count()) ?? 0;
  }

  @override
  Future<int> createRule({
    required String name,
    required String type,
    required int points,
    String? icon,
  }) {
    return _db.into(_db.rules).insert(RulesCompanion.insert(
          name: name,
          type: Value(type),
          points: points,
          icon: icon != null ? Value(icon) : const Value.absent(),
          createdAt: DateTime.now(),
        ));
  }

  @override
  Future<void> toggleRuleStatus(int id, bool isActive) {
    return (_db.update(_db.rules)..where((t) => t.id.equals(id))).write(
      RulesCompanion(isActive: Value(isActive)),
    );
  }

  @override
  Future<void> deleteRule(int id) {
    // 软删除
    return (_db.update(_db.rules)..where((t) => t.id.equals(id))).write(
      const RulesCompanion(isDeleted: Value(true), isActive: Value(false)),
    );
  }

  @override
  Future<void> updateRule({
    required int id,
    required String name,
    required int points,
    String? icon,
  }) {
    return (_db.update(_db.rules)..where((t) => t.id.equals(id))).write(
      RulesCompanion(
        name: Value(name),
        points: Value(points),
        icon: icon != null ? Value(icon) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<bool> isRuleNameExists(String name, {int? excludeId}) async {
    final query = _db.select(_db.rules)
      ..where((t) => t.name.equals(name) & t.isDeleted.equals(false));

    if (excludeId != null) {
      query.where((t) => t.id.equals(excludeId).not());
    }

    final result = await query.get();
    return result.isNotEmpty;
  }

  @override
  Future<Rule?> getRuleByName(String name) {
    return (_db.select(_db.rules)
          ..where((t) => t.name.equals(name) & t.isDeleted.equals(false)))
        .getSingleOrNull();
  }
}
