import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/database/tables.dart';

part 'idiom_failure_records_dao.g.dart';

/// 成语接龙失败记录 DAO
@DriftAccessor(tables: [IdiomFailureRecords])
class IdiomFailureRecordsDao extends DatabaseAccessor<AppDatabase> with _$IdiomFailureRecordsDaoMixin {
  IdiomFailureRecordsDao(super.db);

  /// 记录失败的成语尾字
  Future<void> recordFailure(int childId, String lastChar) async {
    final existing = await (select(idiomFailureRecords)
          ..where((t) => t.childId.equals(childId) & t.lastChar.equals(lastChar)))
        .getSingleOrNull();

    final now = DateTime.now();

    if (existing != null) {
      // 更新失败次数
      await (update(idiomFailureRecords)..where((t) => t.id.equals(existing.id))).write(
        IdiomFailureRecordsCompanion(
          failCount: Value(existing.failCount + 1),
          lastFailedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    } else {
      // 新增记录
      await into(idiomFailureRecords).insert(
        IdiomFailureRecordsCompanion.insert(
          childId: childId,
          lastChar: lastChar,
          lastFailedAt: now,
          createdAt: now,
        ),
      );
    }
  }

  /// 记录成功（用于减少失败权重）
  Future<void> recordSuccess(int childId, String lastChar) async {
    final existing = await (select(idiomFailureRecords)
          ..where((t) => t.childId.equals(childId) & t.lastChar.equals(lastChar)))
        .getSingleOrNull();

    if (existing != null) {
      final now = DateTime.now();
      final newSuccessCount = existing.successCount + 1;

      // 如果成功次数达到 3 次，删除记录
      if (newSuccessCount >= 3) {
        await (delete(idiomFailureRecords)..where((t) => t.id.equals(existing.id))).go();
      } else {
        await (update(idiomFailureRecords)..where((t) => t.id.equals(existing.id))).write(
          IdiomFailureRecordsCompanion(
            successCount: Value(newSuccessCount),
            lastSuccessAt: Value(now),
            updatedAt: Value(now),
          ),
        );
      }
    }
  }

  /// 获取失败的成语尾字列表（按失败次数排序，最多返回指定数量）
  Future<List<String>> getFailedLastChars(int childId, {int limit = 10}) async {
    final records = await (select(idiomFailureRecords)
          ..where((t) => t.childId.equals(childId))
          ..orderBy([
            (t) => OrderingTerm.desc(t.failCount),
            (t) => OrderingTerm.desc(t.lastFailedAt),
          ])
          ..limit(limit))
        .get();

    return records.map((r) => r.lastChar).toList();
  }

  /// 清除指定孩子的所有失败记录
  Future<void> clearAll(int childId) async {
    await (delete(idiomFailureRecords)..where((t) => t.childId.equals(childId))).go();
  }
}
