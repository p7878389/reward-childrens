import 'package:drift/drift.dart';
import 'tables.dart';
import 'connection/connection.dart' as impl;
import 'services/seed_data_service.dart';
import 'dao/log_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Children,
  Rules,
  PointRecords,
  Rewards,
  Exchanges,
  AppContents,
  AppLogs,
  Badges,
  BadgeAcquisitions,
  CheckinRecords,
  // 成语接龙游戏相关表
  Idioms,
  IdiomGameSettings,
  IdiomGameRecords,
  IdiomGradeProgress,
  IdiomFailureRecords,
  IdiomPuzzleRecords,
  IdiomEngagementRecords,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  /// 用于生成预编译数据库的构造函数
  AppDatabase.forGenerator(super.executor);

  late final LogDao logDao = LogDao(this);
  late final SeedDataService _seedService = SeedDataService(this);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedService.seedAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(idiomEngagementRecords, idiomEngagementRecords.lastWrongAt);
          await m.addColumn(idiomEngagementRecords, idiomEngagementRecords.masteryLevel);
          await m.addColumn(idiomEngagementRecords, idiomEngagementRecords.consecutiveCorrect);
        }
      },
    );
  }

  /// 清空所有用户数据（保留系统规则）
  Future<void> clearAllData() async {
    await transaction(() async {
      await delete(pointRecords).go();
      await delete(exchanges).go();
      await delete(children).go();
      await delete(rewards).go();
      await (delete(rules)..where((t) => t.isSystem.equals(false))).go();
    });
  }

  /// 根据 key 获取应用内容
  Future<AppContent?> getAppContent(String key) async {
    return (select(appContents)..where((t) => t.key.equals(key))).getSingleOrNull();
  }

  // ==================== 日志相关方法（委托给 LogDao）====================

  Future<void> insertLogsBatch(List<AppLogsCompanion> logs) => logDao.insertBatch(logs);

  Future<List<AppLog>> queryLogs({
    String? level,
    String? tag,
    String? searchQuery,
    DateTime? startTime,
    DateTime? endTime,
    int limit = 100,
    int offset = 0,
  }) => logDao.query(
    level: level,
    tag: tag,
    searchQuery: searchQuery,
    startTime: startTime,
    endTime: endTime,
    limit: limit,
    offset: offset,
  );

  Future<int> getLogsCount({String? level, String? tag}) => logDao.getCount(level: level, tag: tag);

  Future<void> clearAllLogs() => logDao.clearAll();

  Future<int> cleanOldLogs({int keepDays = 7}) => logDao.cleanOld(keepDays: keepDays);

  Future<List<String>> getDistinctTags() => logDao.getDistinctTags();
}
