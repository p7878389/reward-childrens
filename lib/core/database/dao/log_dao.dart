import 'package:drift/drift.dart';
import '../app_database.dart';

/// 日志数据访问对象
class LogDao {
  final AppDatabase _db;

  LogDao(this._db);

  /// 批量插入日志
  Future<void> insertBatch(List<AppLogsCompanion> logs) async {
    await _db.batch((b) => b.insertAll(_db.appLogs, logs));
  }

  /// 查询日志（支持分页和过滤）
  Future<List<AppLog>> query({
    String? level,
    String? tag,
    String? searchQuery,
    DateTime? startTime,
    DateTime? endTime,
    int limit = 100,
    int offset = 0,
  }) async {
    final query = _db.select(_db.appLogs)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit, offset: offset);

    if (level != null) {
      query.where((t) => t.level.equals(level));
    }
    if (tag != null) {
      query.where((t) => t.tag.equals(tag));
    }
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final escaped = searchQuery.replaceAll('%', r'\%').replaceAll('_', r'\_');
      query.where((t) => t.message.like('%$escaped%') | t.stackTrace.like('%$escaped%') | t.extra.like('%$escaped%'));
    }
    if (startTime != null) {
      query.where((t) => t.createdAt.isBiggerOrEqualValue(startTime));
    }
    if (endTime != null) {
      query.where((t) => t.createdAt.isSmallerOrEqualValue(endTime));
    }

    return query.get();
  }

  /// 获取日志总数
  Future<int> getCount({String? level, String? tag}) async {
    final query = _db.selectOnly(_db.appLogs)..addColumns([_db.appLogs.id.count()]);
    if (level != null) {
      query.where(_db.appLogs.level.equals(level));
    }
    if (tag != null) {
      query.where(_db.appLogs.tag.equals(tag));
    }
    final result = await query.getSingle();
    return result.read(_db.appLogs.id.count()) ?? 0;
  }

  /// 清空所有日志
  Future<void> clearAll() async {
    await _db.delete(_db.appLogs).go();
  }

  /// 清理过期日志
  Future<int> cleanOld({int keepDays = 7}) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: keepDays));
    return (_db.delete(_db.appLogs)..where((t) => t.createdAt.isSmallerThanValue(cutoffDate))).go();
  }

  /// 获取所有不同的标签
  Future<List<String>> getDistinctTags() async {
    final query = _db.selectOnly(_db.appLogs, distinct: true)..addColumns([_db.appLogs.tag]);
    final results = await query.get();
    return results.map((row) => row.read(_db.appLogs.tag)!).toList();
  }
}
