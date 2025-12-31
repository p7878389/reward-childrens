import 'dart:io';
import 'dart:isolate';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:children_rewards/core/services/file_storage_service.dart';

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

    

    final args = <String, Object>{
      'basePath': FileStorageService.basePath,
      'legacyBasePath': FileStorageService.legacyBasePath,
      'mappings': _migrationMap.entries
          .map((entry) => <String>[entry.key, entry.value.name])
          .toList(),
    };

    await Isolate.run(() => _migrateSync(args));
    // 迁移日志已移除

    await prefs.setBool(_migrationKey, true);
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
