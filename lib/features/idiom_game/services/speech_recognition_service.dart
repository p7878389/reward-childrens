import 'dart:async';
import 'dart:convert';
import 'package:vosk_flutter/vosk_flutter.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:children_rewards/core/logging/app_logger.dart';

enum SpeechStatus { idle, listening, processing, error }

/// 语音识别模式
enum SpeechMode {
  /// 系统原生（支持离线，如果设备已下载语音包）
  native,
  /// Vosk 离线识别
  offline,
}

/// 双模式语音识别服务
/// 优先使用系统原生语音识别，失败时自动回退到 Vosk 离线识别
class SpeechRecognitionService {
  static const String _tag = 'SpeechRecognitionService';

  final _statusController = StreamController<SpeechStatus>.broadcast();
  final _textController = StreamController<String>.broadcast();
  final _partialTextController = StreamController<String>.broadcast();

  // Vosk 离线识别
  VoskFlutterPlugin? _vosk;
  Model? _model;
  Recognizer? _recognizer;
  SpeechService? _voskSpeechService;

  // 系统原生语音识别
  final stt.SpeechToText _speechToText = stt.SpeechToText();

  SpeechStatus _currentStatus = SpeechStatus.idle;
  SpeechMode _currentMode = SpeechMode.native;
  bool _voskInitialized = false;

  Stream<SpeechStatus> get statusStream => _statusController.stream;
  Stream<String> get textStream => _textController.stream;
  Stream<String> get partialTextStream => _partialTextController.stream;

  bool get isListening => _currentStatus == SpeechStatus.listening;
  bool get isInitialized => _voskInitialized; // 公开初始化状态
  SpeechMode get currentMode => _currentMode;

  void _updateStatus(SpeechStatus status) {
    _currentStatus = status;
    _statusController.add(status);
  }

  /// 初始化语音识别服务
  Future<void> initialize(String modelPath) async {
    // 关键优化：如果已经初始化，直接返回
    if (_voskInitialized) {
      logger.info(_tag, "Speech engine already initialized, skipping...");
      return;
    }

    // 1. 初始化 Vosk 离线识别 (提前预热，减少启动延迟)
    await _initializeVosk(modelPath);

    // 2. 暂时注释系统原生语音识别逻辑，强制使用本地模型
    /*
    try {
      _nativeAvailable = await _speechToText.initialize(
        onError: (error) {
          logger.warning(_tag, "Native speech error: ${error.errorMsg}");
          if (error.errorMsg.contains('error_busy')) {
            _preferOffline = true;
          }
          if (_currentStatus == SpeechStatus.listening && _voskInitialized) {
            _fallbackToVosk();
          }
        },
        onStatus: (status) {
          logger.debug(_tag, "Native speech status: $status");
        },
      );
    } catch (e) {
      _nativeAvailable = false;
    }
    */
// 强制设为不可用
// 强制偏好离线
    logger.info(_tag, "Native speech recognition disabled by developer. Using offline mode only.");
  }

  /// 初始化 Vosk 离线识别
  Future<void> _initializeVosk(String modelPath) async {
    try {
      _vosk = VoskFlutterPlugin.instance();
      _model = await _vosk!.createModel(modelPath);
      _recognizer = await _vosk!.createRecognizer(model: _model!, sampleRate: 16000);
      
      // 预先创建 SpeechService，实现“秒开”
      _voskSpeechService = await _vosk!.initSpeechService(_recognizer!);
      _voskSpeechService!.onPartial().listen((event) {
        _partialTextController.add(event);
      });
      _voskSpeechService!.onResult().listen(_handleVoskResult);
      
      _voskInitialized = true;
      logger.info(_tag, "Vosk initialized and pre-warmed at $modelPath");
    } catch (e, stack) {
      logger.error(_tag, "Error initializing Vosk: $e", stack);
      _voskInitialized = false;
    }
  }

  void _handleVoskResult(String event) {
    logger.info(_tag, "Vosk RAW Result Event: $event");
    try {
      final decoded = jsonDecode(event);
      String text = decoded['text']?.toString() ?? "";
      
      // 关键修复：移除中文识别结果中可能存在的空格
      text = text.replaceAll(' ', '').trim();
      
      if (text.isNotEmpty) {
        logger.info(_tag, "Vosk SUCCESS: Cleaned text -> '$text'");
        _textController.add(text);
      } else {
        logger.debug(_tag, "Vosk EMPTY: No speech recognized in '$event'");
      }
    } catch (e, stack) {
      logger.error(_tag, "Vosk DECODE ERROR: $e", stack);
    }
  }


  /// 开始监听
  Future<void> startListening() async {
    _updateStatus(SpeechStatus.listening); // 立即更新状态，让 UI 响应点击

    // 强制使用 Vosk 本地模型路径
    if (_voskInitialized) {
      _currentMode = SpeechMode.offline;
      logger.info(_tag, "Offline mode (Forced): Starting Vosk recognition");
      await _startVoskListening();
    } else {
      logger.error(_tag, "Vosk not initialized, cannot start listening");
      _updateStatus(SpeechStatus.error);
    }
  }

  /// 使用 Vosk 离线识别
  Future<void> _startVoskListening() async {
    if (!_voskInitialized || _voskSpeechService == null) {
      logger.error(_tag, "Vosk not ready, cannot start");
      _updateStatus(SpeechStatus.error);
      return;
    }

    logger.info(_tag, "Vosk mode: Starting...");
    try {
      final success = await _voskSpeechService!.start();
      logger.info(_tag, "Vosk Start Result: $success");
    } catch (e) {
      logger.error(_tag, "Vosk start failed: $e");
      _updateStatus(SpeechStatus.error);
    }
  }

  /// 停止监听
  Future<void> stopListening() async {
    try {
      if (_currentMode == SpeechMode.native) {
        await _speechToText.stop();
      } else {
        await _voskSpeechService?.stop();
      }
      _updateStatus(SpeechStatus.idle);
    } catch (e) {
      logger.error(_tag, "Error stopping listening: $e");
    }
  }

  /// 取消监听
  Future<void> cancel() async {
    try {
      if (_currentMode == SpeechMode.native) {
        await _speechToText.cancel();
      } else {
        await _voskSpeechService?.cancel();
      }
      _updateStatus(SpeechStatus.idle);
    } catch (e) {
      logger.error(_tag, "Error canceling listening: $e");
    }
  }

  /// 释放资源
  void dispose() {
    _speechToText.cancel();
    _voskSpeechService?.dispose();
    _recognizer?.dispose();
    _model?.dispose();
    _statusController.close();
    _textController.close();
    _partialTextController.close();
  }
}