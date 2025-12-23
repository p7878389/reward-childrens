import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/features/points/domain/repositories/i_point_records_repository.dart';
import 'package:children_rewards/features/points/domain/models/point_record_detail.dart';

/// 积分记录数据仓库实现
class PointRecordsRepository implements IPointRecordsRepository {
  final AppDatabase _db;

  PointRecordsRepository(this._db);

  @override
  Stream<List<PointRecord>> watchRecords(int childId, {String? filterType}) {
    var query = _db.select(_db.pointRecords)
      ..where((t) => t.childId.equals(childId));

    if (filterType != null && filterType != 'all') {
      if (filterType == 'earned') {
        query = query..where((t) => t.type.equals('earned'));
      } else if (filterType == 'spent') {
        query = query..where((t) => t.type.isIn(['spent', 'deducted']));
      }
    }

    return (query..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)]))
        .watch();
  }

  @override
  Future<List<PointRecordDetail>> getRecordsPaged({
    required int childId,
    String? filterType,
    required int limit,
    required int offset,
  }) {
    final query = _db.select(_db.pointRecords).join([
      leftOuterJoin(_db.rules, _db.rules.id.equalsExp(_db.pointRecords.ruleId)),
    ]);

    query.where(_db.pointRecords.childId.equals(childId));

    if (filterType != null && filterType != 'all') {
      if (filterType == 'earned') {
        query.where(_db.pointRecords.type.equals('earned'));
      } else if (filterType == 'spent') {
        query.where(_db.pointRecords.type.isIn(['spent', 'deducted']));
      }
    }

    query.orderBy([OrderingTerm(expression: _db.pointRecords.createdAt, mode: OrderingMode.desc)]);
    query.limit(limit, offset: offset);

    return query.map((row) {
      final record = row.readTable(_db.pointRecords);
      final rule = row.readTableOrNull(_db.rules);
      return PointRecordDetail(record: record, ruleIcon: rule?.icon);
    }).get();
  }

  @override
  Future<int> getRecordsCount(int childId, {String? filterType}) async {
    final query = _db.selectOnly(_db.pointRecords)
      ..addColumns([_db.pointRecords.id.count()])
      ..where(_db.pointRecords.childId.equals(childId));

    if (filterType != null && filterType != 'all') {
      if (filterType == 'earned') {
        query.where(_db.pointRecords.type.equals('earned'));
      } else if (filterType == 'spent') {
        query.where(_db.pointRecords.type.isIn(['spent', 'deducted']));
      }
    }

    final result = await query.getSingle();
    return result.read(_db.pointRecords.id.count()) ?? 0;
  }

  @override
  Future<Map<String, int>> getStats(int childId) async {
    final earnedExp = _db.pointRecords.points.sum();
    final spentExp = _db.pointRecords.points.sum();

    final earnedQuery = _db.selectOnly(_db.pointRecords)
      ..addColumns([earnedExp])
      ..where(_db.pointRecords.childId.equals(childId))
      ..where(_db.pointRecords.type.equals('earned'));
      
    final spentQuery = _db.selectOnly(_db.pointRecords)
      ..addColumns([spentExp])
      ..where(_db.pointRecords.childId.equals(childId))
      ..where(_db.pointRecords.type.isIn(['spent', 'deducted']));

    final earnedResult = await earnedQuery.map((row) => row.read(earnedExp)).getSingle();
    final spentResult = await spentQuery.map((row) => row.read(spentExp)).getSingle();
      
    return {
      'earned': earnedResult ?? 0,
      'spent': (spentResult ?? 0).abs(),
    };
  }

  @override
  Future<void> addRecord({
    required int childId,
    required int points,
    required String type,
    int? ruleId,
    String? ruleName,
    String? note,
  }) async {
    await addRecordAndReturnId(
      childId: childId,
      points: points,
      type: type,
      ruleId: ruleId,
      ruleName: ruleName,
      note: note,
    );
  }

  @override
  Future<int> addRecordAndReturnId({
    required int childId,
    required int points,
    required String type,
    int? ruleId,
    String? ruleName,
    String? note,
  }) async {
    return _db.transaction(() async {
      // 1. Determine actual points delta
      final int delta = type == 'earned' ? points : -points;
      final now = DateTime.now();

      // 2. Insert Record
      final id = await _db.into(_db.pointRecords).insert(PointRecordsCompanion.insert(
            childId: childId,
            ruleId: Value(ruleId),
            ruleName: Value(ruleName),
            points: delta,
            type: type,
            note: Value(note),
            createdAt: now,
          ));

      // 3. Update Child's Stars
      final child = await (_db.select(_db.children)..where((t) => t.id.equals(childId))).getSingle();

      final newStars = (child.stars + delta) < 0 ? 0 : (child.stars + delta);

      await (_db.update(_db.children)..where((t) => t.id.equals(childId))).write(
        ChildrenCompanion(stars: Value(newStars), updatedAt: Value(now)),
      );

      return id;
    });
  }
}
