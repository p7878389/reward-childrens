import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:children_rewards/features/idiom_game/domain/entities/resource_entities.dart';
import 'package:children_rewards/core/logging/app_logger.dart';
import 'package:children_rewards/core/constants/system_config.dart';
import 'package:children_rewards/features/idiom_game/services/idiom_data_importer.dart';

class ResourceConfig {
  static const resources = {
    ResourceType.voskModel: ResourceInfo(
      name: 'Vosk Model (Small CN)',
      version: '0.22',
      url: kVoskModelZipUrl,
      sizeBytes: 45000000, // Approx 45MB
      md5: 'placeholder_md5',
    ),
    ResourceType.idiomDb: ResourceInfo(
      name: 'Prebuilt Database',
      version: '25.12.31',
      url: kPrebuiltDatabaseUrl,
      sizeBytes: 20000000,
      md5: 'placeholder_md5',
    ),
  };

  /// Vosk 模型 assets 目录下的文件列表
  static const voskModelFiles = [
    'am/final.mdl',
    'conf/mfcc.conf',
    'conf/model.conf',
    'graph/disambig_tid.int',
    'graph/Gr.fst',
    'graph/HCLr.fst',
    'graph/phones/word_boundary.int',
    'ivector/final.dubm',
    'ivector/final.ie',
    'ivector/final.mat',
    'ivector/global_cmvn.stats',
    'ivector/online_cmvn.conf',
    'ivector/splice.conf',
    'README',
  ];
}

class ResourceDownloadService {
  static const String _tag = 'ResourceDownloadService';
  final _statusController = StreamController<Map<ResourceType, DownloadProgress>>.broadcast();
  final Map<ResourceType, DownloadProgress> _currentStatus = {};
  final IdiomDataImporter _importer;

  Stream<Map<ResourceType, DownloadProgress>> get statusStream => _statusController.stream;

  ResourceDownloadService(this._importer) {
    // Initialize status
    for (var type in ResourceType.values) {
      _currentStatus[type] = DownloadProgress.idle(type);
    }
    _emitStatus();
  }

  void dispose() {
    _statusController.close();
  }

  Future<void> startDownload(ResourceType type) async {
    final config = ResourceConfig.resources[type]!;

    try {
      // 1. 先检查是否已经存在
      if (await checkResourceExists(type)) {
        _updateStatus(type, DownloadStatus.completed, message: "Already exists");
        return;
      }

      _updateStatus(type, DownloadStatus.checking, message: "Preparing resources...");

      final appDir = await getApplicationDocumentsDirectory();

      // 2. 尝试从 Assets 导入（优先）
      if (type == ResourceType.voskModel) {
        if (kUseBundledResources) {
          final success = await _copyVoskModelFromAssets(appDir.path);
          if (success) {
            _updateStatus(type, DownloadStatus.completed, message: "Ready");
            return;
          }
        }
      }

      if (type == ResourceType.idiomDb) {
        final tempPath = await _getTempDbPath();
        if (kUseBundledResources) {
          final success = await _importPrebuiltDbFromAssets(tempPath);
          if (success) {
            _updateStatus(type, DownloadStatus.completed, message: "Ready");
            return;
          }
        }

        await _downloadFile(config.url, tempPath, (progress) {
          _updateStatus(type, DownloadStatus.downloading, progress: progress);
        });
        final success = await _importPrebuiltDbFromFile(tempPath);
        if (!success) {
          logger.error(_tag, '导入预编译数据库失败', _importer.lastStackTrace);
          throw Exception('Import from database failed');
        }
        _updateStatus(type, DownloadStatus.completed, message: "Success");
        return;
      }

      // 3. 如果 Assets 导入失败，执行下载
      final savePath = '${appDir.path}/${type.name}.zip';

      if (!File(savePath).existsSync()) {
        await _downloadFile(config.url, savePath, (progress) {
          _updateStatus(type, DownloadStatus.downloading, progress: progress);
        });
      }

      // 4. 解压
      if (savePath.endsWith('.zip')) {
        _updateStatus(type, DownloadStatus.extracting, message: "Unzipping model...");
        await _unzipFile(savePath, appDir.path);
        await File(savePath).delete();
      }

      _updateStatus(type, DownloadStatus.completed, message: "Success");

    } catch (e) {
      _updateStatus(type, DownloadStatus.error, error: e.toString());
    }
  }

  /// 从 Assets 复制 Vosk 模型文件夹
  Future<bool> _copyVoskModelFromAssets(String destDir) async {
    try {
      _updateStatus(ResourceType.voskModel, DownloadStatus.downloading, message: "Copying from assets...");

      final modelDir = Directory('$destDir/$kVoskModelDirName');
      if (!modelDir.existsSync()) {
        modelDir.createSync(recursive: true);
      }

      // 复制所有模型文件
      for (final filePath in ResourceConfig.voskModelFiles) {
        final assetPath = '$kVoskModelAssetBasePath/$filePath';
        final destPath = '${modelDir.path}/$filePath';

        // 确保目标目录存在
        final destFile = File(destPath);
        destFile.parent.createSync(recursive: true);

        // 从 assets 读取并写入
        final data = await rootBundle.load(assetPath);
        await destFile.writeAsBytes(data.buffer.asUint8List());
      }

      logger.info(_tag, "Vosk model copied from assets successfully");
      return true;
    } catch (e) {
      logger.warning(_tag, "Failed to copy Vosk model from assets: $e");
      return false;
    }
  }

  Future<String> _getTempDbPath() async {
    final appDir = await getApplicationDocumentsDirectory();
    return '${appDir.path}/temp_idiom_prebuilt.db';
  }

  Future<bool> _importPrebuiltDbFromAssets(String tempPath) async {
    try {
      _updateStatus(ResourceType.idiomDb, DownloadStatus.downloading, message: "Copying from assets...");
      final file = File(tempPath);
      await file.parent.create(recursive: true);
      final data = await rootBundle.load(kPrebuiltDatabaseAssetPath);
      await file.writeAsBytes(data.buffer.asUint8List());
      final success = await _importPrebuiltDbFromFile(tempPath);
      if (success) {
        logger.info(_tag, "Prebuilt database imported from assets successfully");
      }
      return success;
    } catch (e) {
      logger.warning(_tag, "Failed to import prebuilt database from assets: $e");
      return false;
    }
  }

  Future<bool> _importPrebuiltDbFromFile(String tempPath) async {
    final tempFile = File(tempPath);
    if (!await tempFile.exists()) {
      return false;
    }
    final success = await _importer.importFromExternalDb(tempPath);
    try {
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
    } catch (_) {}
    return success;
  }

  Future<void> _downloadFile(String url, String savePath, Function(double) onProgress) async {
    final request = http.Request('GET', Uri.parse(url));
    final response = await http.Client().send(request);
    
    if (response.statusCode != 200) {
      throw Exception('Download failed: ${response.statusCode}');
    }

    final contentLength = response.contentLength ?? 0;
    var received = 0;
    final file = File(savePath);
    final sink = file.openWrite();

    await response.stream.listen(
      (List<int> chunk) {
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
      cancelOnError: true,
    ).asFuture();
  }

  Future<void> _unzipFile(String zipPath, String destPath) async {
    final inputStream = InputFileStream(zipPath);
    final archive = ZipDecoder().decodeBuffer(inputStream);
    
    for (var file in archive.files) {
      if (file.isFile) {
        final outputStream = OutputFileStream('$destPath/${file.name}');
        file.writeContent(outputStream);
        outputStream.close();
      }
    }
  }

  void _updateStatus(ResourceType type, DownloadStatus status, {double progress = 0.0, String? message, String? error}) {
    _currentStatus[type] = DownloadProgress(
      type: type,
      status: status,
      progress: progress,
      message: message,
      error: error,
    );
    _emitStatus();
  }

  void _emitStatus() {
    _statusController.add(Map.unmodifiable(_currentStatus));
  }
  
  /// Check if resource exists locally
  Future<bool> checkResourceExists(ResourceType type) async {
    final appDir = await getApplicationDocumentsDirectory();
    if (type == ResourceType.voskModel) {
      // 检查关键模型文件是否存在（而非仅检查目录）
      final modelFile = File('${appDir.path}/$kVoskModelDirName/am/final.mdl');
      return modelFile.exists();
    } else {
      final count = await _importer.getIdiomCount();
      return count > 0;
    }
  }
}
