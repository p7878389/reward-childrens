import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/core/constants/system_config.dart';
import 'package:children_rewards/core/services/file_storage_service.dart';
import 'package:children_rewards/features/idiom_game/providers/idiom_game_providers.dart';

enum ResourceStatus {
  idle,
  downloading,
  extracting,
  installed,
  error,
}

class ResourceState {
  final ResourceStatus status;
  final double progress;
  final String? errorMessage;
  final String? localPath;

  ResourceState({
    this.status = ResourceStatus.idle,
    this.progress = 0.0,
    this.errorMessage,
    this.localPath,
  });

  ResourceState copyWith({
    ResourceStatus? status,
    double? progress,
    String? errorMessage,
    String? localPath,
  }) {
    return ResourceState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
      localPath: localPath ?? this.localPath,
    );
  }
}

class ResourceDefinition {
  final String id;
  final String name;
  final String description;
  final String url;
  final bool isZip;
  final String targetName; 

  const ResourceDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.targetName,
    this.isZip = true,
  });
}

// 定义资源列表
final resourceDefinitions = [
  const ResourceDefinition(
    id: 'vosk_model',
    name: '成语接龙语音模型',
    description: 'Vosk 中文语音识别模型 (vosk-model-small-cn-0.22)',
    url: kVoskModelZipUrl,
    targetName: kVoskModelDirName,
    isZip: true,
  ),
  const ResourceDefinition(
    id: 'idiom_db',
    name: '成语预编译数据库',
    description: '包含完整成语数据的预编译库',
    url: kPrebuiltDatabaseUrl,
    targetName: kDatabaseFileName,
    isZip: false,
  ),
];

class ResourceDownloadNotifier extends StateNotifier<Map<String, ResourceState>> {
  final Ref ref;

  ResourceDownloadNotifier(this.ref) : super({}) {
    for (var def in resourceDefinitions) {
      state = {...state, def.id: ResourceState()};
    }
    _checkInstalledStatus();
  }

  Future<String> _getFinalInstallPath(ResourceDefinition def) async {
    final appDir = await getApplicationDocumentsDirectory();
    
    if (def.id == 'vosk_model') {
      return p.join(appDir.path, def.targetName);
    } else if (def.id == 'idiom_db') {
      return FileStorageService.getDatabasePath(kDatabaseFileName);
    }
    return appDir.path;
  }

  Future<void> _checkInstalledStatus() async {
    for (var def in resourceDefinitions) {
      final installPath = await _getFinalInstallPath(def);
      bool isInstalled = false;

      if (def.id == 'vosk_model') {
        final modelFile = File(p.join(installPath, 'am', 'final.mdl'));
        isInstalled = await modelFile.exists();
      } else if (def.id == 'idiom_db') {
        final dbFile = File(installPath);
        if (await dbFile.exists()) {
          final importer = ref.read(idiomDataImporterProvider);
          final count = await importer.getIdiomCount();
          isInstalled = count > 0;
        }
      }

      if (isInstalled) {
         state = {
          ...state,
          def.id: state[def.id]!.copyWith(
            status: ResourceStatus.installed,
            progress: 1.0,
            localPath: installPath,
          ),
        };
      }
    }
  }

  Future<void> downloadResource(String id) async {
    final def = resourceDefinitions.firstWhere((e) => e.id == id);
    
    state = {
      ...state,
      id: state[id]!.copyWith(status: ResourceStatus.downloading, progress: 0.0, errorMessage: null),
    };

    try {
      final appDir = await getApplicationDocumentsDirectory();
      final tempDownloadDir = Directory(p.join(appDir.path, 'temp_download_${def.id}'));
      if (await tempDownloadDir.exists()) {
        await tempDownloadDir.delete(recursive: true);
      }
      await tempDownloadDir.create(recursive: true);

      final extension = def.isZip ? '.zip' : p.extension(def.url);
      final downloadFilePath = p.join(tempDownloadDir.path, 'download$extension');

      await _downloadFile(def.url, downloadFilePath, (progress) {
        final maxProgress = def.isZip ? 0.7 : 0.9;
        state = {
          ...state,
          id: state[id]!.copyWith(progress: progress * maxProgress),
        };
      });

      if (def.isZip) {
        state = {
          ...state,
          id: state[id]!.copyWith(status: ResourceStatus.extracting, progress: 0.75),
        };
        await _unzipFile(downloadFilePath, tempDownloadDir.path);
        await File(downloadFilePath).delete();
      }

      state = {
        ...state,
        id: state[id]!.copyWith(status: ResourceStatus.extracting, progress: 0.9),
      };
      
      if (def.id == 'idiom_db') {
        state = {
          ...state,
          id: state[id]!.copyWith(status: ResourceStatus.extracting, progress: 0.95),
        };
        final importer = ref.read(idiomDataImporterProvider);
        final success = await importer.importFromExternalDb(downloadFilePath);
        if (!success) {
          logError(
            '导入预编译数据库失败',
            error: importer.lastError ?? 'unknown',
            stackTrace: importer.lastStackTrace,
          );
          throw Exception("Import from database failed");
        }
      } else {
        final finalPath = await _getFinalInstallPath(def);
        await _installResource(def, tempDownloadDir, finalPath);
      }

      if (await tempDownloadDir.exists()) {
        await tempDownloadDir.delete(recursive: true);
      }

      final localPath = def.id == 'idiom_db'
          ? await FileStorageService.getDatabasePath(kDatabaseFileName)
          : await _getFinalInstallPath(def);
      state = {
        ...state,
        id: state[id]!.copyWith(status: ResourceStatus.installed, progress: 1.0, errorMessage: null, localPath: localPath),
      };
      
      logInfo('Resource installed successfully: ${def.name} -> $localPath');

    } catch (e, st) {
      logError('Failed to download/install resource: ${def.name}', error: e, stackTrace: st);
      state = {
        ...state,
        id: state[id]!.copyWith(status: ResourceStatus.error, errorMessage: e.toString()),
      };
    }
  }

  Future<void> _downloadFile(String url, String savePath, Function(double) onProgress) async {
    final request = http.Request('GET', Uri.parse(url));
    final response = await http.Client().send(request);
    
    if (response.statusCode != 200) {
      throw Exception('Download failed with status: ${response.statusCode}');
    }

    final contentLength = response.contentLength ?? 0;
    var received = 0;
    final file = File(savePath);
    final sink = file.openWrite();

    await response.stream.listen(
      (chunk) {
        sink.add(chunk);
        received += chunk.length;
        if (contentLength > 0) {
          onProgress(received / contentLength);
        }
      },
      onDone: () async {
        await sink.close();
      },
      onError: (e) {
        sink.close();
        throw e;
      },
    ).asFuture();
  }

  Future<void> _unzipFile(String zipPath, String destPath) async {
    final bytes = await File(zipPath).readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);
    
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        File(p.join(destPath, filename))
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        Directory(p.join(destPath, filename)).create(recursive: true);
      }
    }
  }

  Future<void> _installResource(ResourceDefinition def, Directory tempDir, String finalPath) async {
    final targetDir = Directory(finalPath).parent;
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }
    
    if (await FileSystemEntity.type(finalPath) != FileSystemEntityType.notFound) {
      if (await FileSystemEntity.isDirectory(finalPath)) {
        await Directory(finalPath).delete(recursive: true);
      } else {
        await File(finalPath).delete();
      }
    }

    if (def.id == 'vosk_model') {
      Directory? modelRoot;
      await for (final entity in tempDir.list(recursive: true, followLinks: false)) {
        if (entity is File && entity.path.endsWith('am/final.mdl')) {
          modelRoot = entity.parent.parent;
          break;
        }
      }

      if (modelRoot == null) {
        throw Exception('Invalid Vosk model: could not find "am/final.mdl" in archive.');
      }
      await modelRoot.rename(finalPath);
      
    } else if (def.id == 'idiom_db') {
      // 策略：如果是 Zip，寻找 .db 文件；如果是单文件，直接重命名
      File? dbFile;
      if (def.isZip) {
        final dbFiles = <File>[];
        await for (final entity in tempDir.list(recursive: true, followLinks: false)) {
          if (entity is File && entity.path.endsWith('.db') && !entity.path.contains('__MACOSX')) {
            dbFiles.add(entity);
          }
        }
        if (dbFiles.isEmpty) throw Exception('No .db file found in archive.');
        dbFiles.sort((a, b) => b.lengthSync().compareTo(a.lengthSync()));
        dbFile = dbFiles.first;
      } else {
        // 单文件查找：排除临时命名的 download.xxx
        await for (final entity in tempDir.list()) {
          if (entity is File && entity.path.endsWith('.db')) {
             dbFile = entity;
             break;
          }
        }
        // 如果上面没找到（例如 URL 没 .db 后缀导致重命名为了 download.zip/xxx），则直接取唯一的那个文件
        if (dbFile == null) {
           final files = await tempDir.list().where((e) => e is File).toList();
           if (files.isNotEmpty) dbFile = files.first as File;
        }
      }

      if (dbFile == null) throw Exception('Database file not found in temp directory.');
      
      final tempTarget = File('$finalPath.download');
      await dbFile.copy(tempTarget.path);
      if (await File(finalPath).exists()) {
        await File(finalPath).delete();
      }
      await tempTarget.rename(finalPath);
    }
  }
}

final resourceDownloadProvider = StateNotifierProvider<ResourceDownloadNotifier, Map<String, ResourceState>>((ref) {
  return ResourceDownloadNotifier(ref);
});
