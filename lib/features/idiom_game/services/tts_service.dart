import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    await _flutterTts.setLanguage("zh-CN");
    await _flutterTts.setSpeechRate(0.4); // Slower rate for children
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    
    _isInitialized = true;
  }

  Future<void> speak(String text, {String? pinyin}) async {
    if (!_isInitialized) await initialize();
    // 目前 flutter_tts 主要依赖系统引擎的智能分词，传入拼音参数作为未来扩展（如 SSML 支持）的预留
    // TODO: 如果系统 TTS 对多音字识别不准，未来可在此处实现同音字替换逻辑或接入云端 TTS
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
  
  void dispose() {
    _flutterTts.stop();
  }
}