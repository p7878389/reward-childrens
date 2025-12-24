import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/services/file_storage_service.dart';

class DatabaseBackupService {
  static const String _dbName = 'children_rewards.db';
  final AppDatabase? _db;

  DatabaseBackupService([this._db]);

  Future<File> _getDbFile() async {
    final newPath = await FileStorageService.getDatabasePath(_dbName);
    final newFile = File(newPath);
    if (await newFile.exists()) {
      return newFile;
    }

    final legacyFolder = await getApplicationDocumentsDirectory();
    final legacyFile = File(p.join(legacyFolder.path, _dbName));
    if (await legacyFile.exists()) {
      return legacyFile;
    }

    return newFile;
  }

  /// 导出数据库
  Future<void> exportDatabase() async {
    try {
      final dbFile = await _getDbFile();
      if (!await dbFile.exists()) {
        throw Exception("数据库文件不存在: ${dbFile.path}");
      }

      // Create a temporary copy with timestamp
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final backupFileName = 'children_rewards_backup_$timestamp.db';
      final backupFile = await dbFile.copy(p.join(tempDir.path, backupFileName));

      // Share the file
      // ignore: deprecated_member_use
      await Share.shareXFiles(
        [XFile(backupFile.path)],
        subject: 'Children Rewards Backup',
        text: 'Backup file for Children Rewards app',
      );
    } catch (e) {
      debugPrint('Export failed: $e');
      rethrow;
    }
  }

  /// 导入数据库
  /// 返回 true 表示导入成功，需要重启
  Future<bool> importDatabase() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Select Backup File',
        type: FileType.any,
      );

      if (result == null || result.files.single.path == null) {
        return false;
      }

      final sourcePath = result.files.single.path!;
      final dbFile = await _getDbFile();

      // 关闭数据库连接后再覆盖文件
      if (_db != null) {
        await _db.close();
      }

      final sourceFile = File(sourcePath);
      await sourceFile.copy(dbFile.path);

      return true;
    } catch (e) {
      debugPrint('Import failed: $e');
      rethrow;
    }
  }
}
