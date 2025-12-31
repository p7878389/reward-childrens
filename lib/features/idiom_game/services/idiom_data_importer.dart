import 'dart:io';
import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/logging/app_logger.dart';

/// 成语数据导入器 - 从外部数据库导入成语数据
class IdiomDataImporter {
  static const String _tag = 'IdiomDataImporter';
  final AppDatabase _db;
  Object? _lastError;
  StackTrace? _lastStackTrace;

  IdiomDataImporter(this._db);

  Object? get lastError => _lastError;
  StackTrace? get lastStackTrace => _lastStackTrace;

  /// 检查并导入成语数据（如果数据库为空）
  Future<bool> importIfNeeded() async {
    final countQuery = _db.selectOnly(_db.idioms)..addColumns([_db.idioms.id.count()]);
    final result = await countQuery.getSingle();
    final count = result.read(_db.idioms.id.count()) ?? 0;

    logger.info(_tag, 'importIfNeeded: 当前成语数量=$count');
    return count > 0;
  }

  /// 从外部预编译数据库文件导入成语数据
  /// 使用 ATTACH DATABASE 策略进行高效合并
  Future<bool> importFromExternalDb(String dbPath) async {
    final file = File(dbPath);
    if (!await file.exists()) {
      _lastError = '文件不存在';
      _lastStackTrace = null;
      logger.error(_tag, 'importFromExternalDb: 文件不存在 $dbPath');
      return false;
    }

    logger.info(_tag, 'importFromExternalDb: 开始从 $dbPath 导入数据...');
    try {
      _lastError = null;
      _lastStackTrace = null;
      // 1. 清空当前成语表 (假设我们要全量更新成语库)
      // 注意：这会删除用户可能自定义添加的成语（如果有的话）。
      // 如果需要保留用户数据，策略需要调整（如 INSERT OR IGNORE）。
      // 这里假设 prebuilt.db 是权威数据源。
      await _db.delete(_db.idioms).go();
      logger.info(_tag, '已清空旧成语数据');

      // 2. 使用 CustomStatement 执行 ATTACH 和 INSERT
      // Drift 的 executor 允许执行原始 SQL
      await _db.customStatement("ATTACH DATABASE '$dbPath' AS external_db");
      
      try {
        final localColumns = await _getIdiomColumns();
        final externalColumns = await _getIdiomColumns(schema: 'external_db');
        final commonColumns = localColumns.where(externalColumns.contains).toList();

        if (commonColumns.isEmpty) {
          throw Exception('成语表结构不兼容，无法导入');
        }

        final columnList = commonColumns.join(', ');
        await _db.customStatement("""
          INSERT INTO idioms ($columnList)
          SELECT $columnList
          FROM external_db.idioms
        """);
        
        logger.info(_tag, '数据导入成功');
      } finally {
        // 无论成功失败，都要 detach
        await _db.customStatement("DETACH DATABASE external_db");
      }

      final count = await getIdiomCount();
      logger.info(_tag, '导入完成，当前成语总数: $count');
      return true;

    } catch (e, stack) {
      _lastError = e;
      _lastStackTrace = stack;
      logger.error(_tag, '导入失败: $e', stack);
      return false;
    }
  }

  Future<List<String>> _getIdiomColumns({String? schema}) async {
    final pragmaSql = schema == null
        ? 'PRAGMA table_info(idioms)'
        : 'PRAGMA $schema.table_info(idioms)';
    final rows = await _db.customSelect(pragmaSql).get();
    return rows
        .map((row) => row.data['name'])
        .whereType<String>()
        .toList();
  }

  /// 获取当前成语数量
  Future<int> getIdiomCount() async {
    final countQuery = _db.selectOnly(_db.idioms)..addColumns([_db.idioms.id.count()]);
    final result = await countQuery.getSingle();
    return result.read(_db.idioms.id.count()) ?? 0;
  }

  /// 占位兼容旧代码
  Future<bool> importFromAssets() async {
    logger.warning(_tag, 'importFromAssets: 已禁用');
    return false;
  }
  
  Future<bool> forceReimport() async {
      return false;
  }
}
