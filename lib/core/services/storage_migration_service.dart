import 'dart:io';
import 'dart:isolate';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:children_rewards/core/services/file_storage_service.dart';
import 'package:children_rewards/core/services/logger_service.dart';

/// 存储迁移服务
class StorageMigrationService {
  static const _migrationKey = 'storage_v2_migrated';

  /// 旧目录到新模块的映射
  static const _migrationMap = {
    'avatars': StorageModule.children,
    'badges': StorageModule.badges,
    'rewards': StorageModule.rewards,
    'rules': StorageModule.rules,
  };

  /// 执行迁移（如果需要）
  static Future<void> migrateIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_migrationKey) == true) return;

    logInfo('开始存储迁移...', tag: 'StorageMigration');

    final args = <String, Object>{
      'basePath': FileStorageService.basePath,
      'legacyBasePath': FileStorageService.legacyBasePath,
      'mappings': _migrationMap.entries
          .map((entry) => <String>[entry.key, entry.value.name])
          .toList(),
    };

    final result = await Isolate.run(() => _migrateSync(args));
    final migrated = (result['migrated'] as List).cast<String>();
    final failed = (result['failed'] as List).cast<String>();
    final timings = (result['timings'] as List).cast<Map>();
    final totalMs = result['totalMs'] as int;

    for (final item in migrated) {
      logInfo('迁移目录 $item 完成，已删除旧目录', tag: 'StorageMigration');
    }
    for (final item in failed) {
      logError('迁移目录 $item 失败', tag: 'StorageMigration');
    }
    for (final timing in timings) {
      final label = timing['label'] as String;
      final ms = timing['ms'] as int;
      logInfo('迁移耗时 $label: ${ms}ms', tag: 'StorageMigration');
    }
    logInfo('迁移总耗时 ${totalMs}ms', tag: 'StorageMigration');

    await prefs.setBool(_migrationKey, true);
    logInfo('存储迁移完成', tag: 'StorageMigration');
  }

  /// 后台迁移执行（Isolate 中运行）
  static Map<String, Object> _migrateSync(Map<String, Object> args) {
    final basePath = args['basePath'] as String;
    final legacyBasePath = args['legacyBasePath'] as String;
    final mappings = (args['mappings'] as List).cast<List>();
    final migrated = <String>[];
    final failed = <String>[];
    final timings = <Map<String, Object>>[];
    final totalWatch = Stopwatch()..start();

    for (final pair in mappings) {
      final oldDirName = pair[0] as String;
      final moduleName = pair[1] as String;
      final label = '$oldDirName -> $moduleName';
      final watch = Stopwatch()..start();
      try {
        _migrateDirectorySync(legacyBasePath, basePath, oldDirName, moduleName);
        migrated.add(label);
      } catch (e) {
        failed.add(label);
      } finally {
        watch.stop();
        timings.add(<String, Object>{
          'label': label,
          'ms': watch.elapsedMilliseconds,
        });
      }
    }
    totalWatch.stop();

    return <String, Object>{
      'migrated': migrated,
      'failed': failed,
      'timings': timings,
      'totalMs': totalWatch.elapsedMilliseconds,
    };
  }

  /// 迁移单个目录（同步 IO，仅在后台使用）
  static void _migrateDirectorySync(
    String legacyBasePath,
    String basePath,
    String oldDirName,
    String moduleName,
  ) {
    try {
      final oldDir = Directory('$legacyBasePath/$oldDirName');
      if (!oldDir.existsSync()) return;

      final newDir = Directory('$basePath/${StorageType.media.name}/$moduleName');
      if (!newDir.existsSync()) {
        newDir.createSync(recursive: true);
      }

      final files = oldDir.listSync().whereType<File>();
      for (final file in files) {
        final fileName = file.path.split('/').last;
        final newPath = '${newDir.path}/$fileName';

        // 复制文件到新位置
        if (!File(newPath).existsSync()) {
          file.copySync(newPath);
        }
      }

      // 迁移完成后删除旧目录
      oldDir.deleteSync(recursive: true);
    } catch (e) {
      rethrow;
    }
  }
}
