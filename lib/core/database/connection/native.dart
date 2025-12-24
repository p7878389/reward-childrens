import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:children_rewards/core/services/file_storage_service.dart';

const _dbName = 'children_rewards.db';
const _prebuiltAsset = 'assets/database/prebuilt.db';

/// 在 Isolate 中写入文件
Future<void> _writeFileInBackground(Map<String, dynamic> params) async {
  final path = params['path'] as String;
  final data = params['data'] as Uint8List;
  await File(path).writeAsBytes(data);
}

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

    // 首次安装：复制预编译数据库（在后台线程执行）
    if (!await file.exists()) {
      try {
        final bytes = await rootBundle.load(_prebuiltAsset);
        await file.parent.create(recursive: true);
        // 在后台 Isolate 中写入大文件
        await compute(_writeFileInBackground, {
          'path': dbPath,
          'data': bytes.buffer.asUint8List(),
        });
        debugPrint('[Database] 预编译数据库复制成功');
      } catch (e) {
        // 预编译数据库不存在或复制失败，回退到正常创建
        debugPrint('[Database] 预编译数据库复制失败: $e');
      }
    }

    return NativeDatabase.createInBackground(file);
  });
}
