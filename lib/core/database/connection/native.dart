import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:children_rewards/core/services/file_storage_service.dart';
import 'package:children_rewards/core/constants/system_config.dart';

const _dbName = kDatabaseFileName;

QueryExecutor connect() {
  return LazyDatabase(() async {
    // 检查旧路径是否存在数据库（兼容旧版本）
    final legacyDbFolder = await getApplicationDocumentsDirectory();
    final legacyFile = File(p.join(legacyDbFolder.path, _dbName));

    if (await legacyFile.exists()) {
      return NativeDatabase.createInBackground(legacyFile);
    }

    // 新安装使用新路径
    final dbPath = await FileStorageService.getDatabasePath(_dbName);
    final file = File(dbPath);

    // 数据库文件缺失时由 Drift 自动创建，预编译数据库在进入成语功能后按需下载

    return NativeDatabase.createInBackground(file);
  });
}
