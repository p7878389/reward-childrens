import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// 存储模块枚举
enum StorageModule {
  children,
  badges,
  rewards,
  rules,
  idiomGame,
}

/// 存储类型枚举
enum StorageType {
  data,
  media,
  cache,
  logs,
  export,
}

/// 统一文件存储服务
class FileStorageService {
  static const _packageName = 'com.growth.starTrack';
  static String? _basePath;
  static String? _legacyBasePath;

  /// 初始化（应用启动时调用一次）
  static Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();
    _legacyBasePath = appDir.path;
    _basePath = '${appDir.path}/$_packageName';

    // 确保基础目录存在
    final baseDir = Directory(_basePath!);
    if (!baseDir.existsSync()) {
      await baseDir.create(recursive: true);
    }
  }

  /// 获取基础路径
  static String get basePath {
    assert(_basePath != null, 'FileStorageService 未初始化，请先调用 init()');
    return _basePath!;
  }

  /// 获取旧版基础路径（用于兼容）
  static String get legacyBasePath {
    assert(_legacyBasePath != null, 'FileStorageService 未初始化');
    return _legacyBasePath!;
  }

  /// 获取模块目录路径
  static Future<String> getModulePath(StorageModule module, StorageType type) async {
    final dir = Directory('$basePath/${type.name}/${module.name}');
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }

  /// 获取类型目录路径
  static Future<String> getTypePath(StorageType type) async {
    final dir = Directory('$basePath/${type.name}');
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }

  /// 保存文件，返回相对路径
  static Future<String> saveFile(
    File source,
    StorageModule module, {
    String? fileName,
    String? subDir,
  }) async {
    final dir = await getModulePath(module, StorageType.media);
    final targetDir = subDir != null ? '$dir/$subDir' : dir;

    // 确保目标目录存在
    final targetDirObj = Directory(targetDir);
    if (!targetDirObj.existsSync()) {
      await targetDirObj.create(recursive: true);
    }

    final name = fileName ?? '${DateTime.now().millisecondsSinceEpoch}${p.extension(source.path)}';
    final dest = File('$targetDir/$name');
    await source.copy(dest.path);

    // 返回相对于 basePath 的路径
    final relativePath = subDir != null
        ? '${StorageType.media.name}/${module.name}/$subDir/$name'
        : '${StorageType.media.name}/${module.name}/$name';
    return relativePath;
  }

  /// 获取文件绝对路径（支持新旧格式）
  static String getAbsolutePath(String relativePath) {
    // 新格式路径 (media/xxx, data/xxx, etc.)
    if (_isNewFormatPath(relativePath)) {
      return '$basePath/$relativePath';
    }
    // 旧格式路径 (avatars/xxx, badges/xxx, etc.)
    return '$legacyBasePath/$relativePath';
  }

  /// 判断是否为新格式路径
  static bool _isNewFormatPath(String path) {
    return path.startsWith('media/') ||
        path.startsWith('data/') ||
        path.startsWith('cache/') ||
        path.startsWith('logs/') ||
        path.startsWith('export/');
  }

  /// 删除文件
  static Future<void> deleteFile(String relativePath) async {
    final file = File(getAbsolutePath(relativePath));
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// 获取数据库文件路径
  static Future<String> getDatabasePath(String dbName) async {
    final dataDir = await getTypePath(StorageType.data);
    return '$dataDir/$dbName';
  }

  /// 获取日志目录路径
  static Future<String> getLogsPath() async {
    return getTypePath(StorageType.logs);
  }
}
