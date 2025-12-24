import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:children_rewards/features/idiom_game/domain/entities/resource_entities.dart';
import 'package:children_rewards/core/logging/app_logger.dart';

class ResourceConfig {
  static const resources = {
    ResourceType.voskModel: ResourceInfo(
      name: 'Vosk Model (Small CN)',
      version: '0.22',
      url: 'https://alphacephei.com/vosk/models/vosk-model-small-cn-0.22.zip',
      sizeBytes: 45000000, // Approx 45MB
      md5: 'placeholder_md5',
    ),
    ResourceType.idiomDb: ResourceInfo(
      name: 'Idiom Database',
      version: '1.0',
      // url: 'https://raw.githubusercontent.com/crazywhalecc/static/gh-pages/idiom/idiom.json',
      url: 'https://raw.githubusercontent.com/mapull/chinese-dictionary/refs/heads/main/idiom/idiom.json',
      sizeBytes: 3000000, // Approx 3MB
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

  Stream<Map<ResourceType, DownloadProgress>> get statusStream => _statusController.stream;

  ResourceDownloadService() {
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
        final success = await _copyVoskModelFromAssets(appDir.path);
        if (success) {
          _updateStatus(type, DownloadStatus.completed, message: "Ready");
          return;
        }
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

      final modelDir = Directory('$destDir/vosk-model-small-cn-0.22');
      if (!modelDir.existsSync()) {
        modelDir.createSync(recursive: true);
      }

      // 复制所有模型文件
      for (final filePath in ResourceConfig.voskModelFiles) {
        final assetPath = 'assets/idiom_game/models/vosk-model-small-cn-0.22/$filePath';
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
      final modelFile = File('${appDir.path}/vosk-model-small-cn-0.22/am/final.mdl');
      return modelFile.exists();
    } else {
      return File('${appDir.path}/idiom.json').exists();
    }
  }
}
