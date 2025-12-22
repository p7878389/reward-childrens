import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:children_rewards/core/logging/app_logger.dart' as db_logger;
import 'package:children_rewards/core/logging/log_level.dart';

/// 日志配置
class LogConfig {
  /// 当前日志级别，低于此级别的日志不会输出
  final LogLevel level;

  /// 是否显示时间戳
  final bool showTimestamp;

  /// 是否显示调用位置
  final bool showCaller;

  /// 是否使用 emoji
  final bool useEmoji;

  const LogConfig({
    this.level = LogLevel.debug,
    this.showTimestamp = true,
    this.showCaller = true,
    this.useEmoji = true,
  });

  /// 调试环境配置
  static const debug = LogConfig(
    level: LogLevel.debug,
    showTimestamp: true,
    showCaller: true,
    useEmoji: true,
  );

  /// 生产环境配置
  static const production = LogConfig(
    level: LogLevel.error,
    showTimestamp: false,
    showCaller: false,
    useEmoji: false,
  );
}

/// 日志服务 - 单例模式
class Logger {
  static Logger? _instance;
  static Logger get instance => _instance ??= Logger._();

  LogConfig _config = kDebugMode ? LogConfig.debug : LogConfig.production;

  Logger._();

  /// 初始化日志配置
  static void init({LogConfig? config}) {
    if (config != null) {
      instance._config = config;
    } else {
      // 根据编译模式自动选择配置
      instance._config = kDebugMode ? LogConfig.debug : LogConfig.production;
    }
    instance.info('Logger initialized with level: ${instance._config.level.label}');
  }

  /// 动态设置日志级别
  static void setLevel(LogLevel level) {
    instance._config = LogConfig(
      level: level,
      showTimestamp: instance._config.showTimestamp,
      showCaller: instance._config.showCaller,
      useEmoji: instance._config.useEmoji,
    );
  }

  /// 获取当前日志级别
  static LogLevel get currentLevel => instance._config.level;

  /// Debug 级别日志
  void debug(String message, {String? tag, Object? data}) {
    _log(LogLevel.debug, message, tag: tag, data: data);
  }

  /// Info 级别日志
  void info(String message, {String? tag, Object? data}) {
    _log(LogLevel.info, message, tag: tag, data: data);
  }

  /// Warning 级别日志
  void warning(String message, {String? tag, Object? data}) {
    _log(LogLevel.warning, message, tag: tag, data: data);
  }

  /// Error 级别日志
  void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.error,
      message,
      tag: tag,
      data: error,
      stackTrace: stackTrace,
    );
  }

  /// 核心日志方法
  void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? data,
    StackTrace? stackTrace,
  }) {
    // 检查日志级别
    if (level.value < _config.level.value) return;

    final buffer = StringBuffer();

    // 添加 emoji
    if (_config.useEmoji) {
      buffer.write('${level.emoji} ');
    }

    // 添加时间戳
    if (_config.showTimestamp) {
      final now = DateTime.now();
      final timestamp = '${now.hour.toString().padLeft(2, '0')}:'
          '${now.minute.toString().padLeft(2, '0')}:'
          '${now.second.toString().padLeft(2, '0')}.'
          '${now.millisecond.toString().padLeft(3, '0')}';
      buffer.write('[$timestamp] ');
    }

    // 添加级别标签
    buffer.write('[${level.label}]');

    // 添加自定义标签
    if (tag != null) {
      buffer.write('[$tag]');
    }

    // 添加调用位置
    if (_config.showCaller && level == LogLevel.error) {
      final caller = _getCaller();
      if (caller != null) {
        buffer.write('[$caller]');
      }
    }

    buffer.write(' $message');

    // 添加附加数据
    if (data != null) {
      buffer.write('\n  Data: $data');
    }

    // 输出日志
    final logMessage = buffer.toString();

    if (kDebugMode) {
      // 调试模式使用 debugPrint，避免日志被截断
      debugPrint(logMessage);

      // 同时使用 developer.log 以便在 DevTools 中查看
      developer.log(
        message,
        name: tag ?? 'App',
        level: level.value * 500,
        error: data is Exception || data is Error ? data : null,
        stackTrace: stackTrace,
      );
    } else {
      // 生产模式只输出 error 级别
      if (level == LogLevel.error) {
        debugPrint(logMessage);
      }
    }

    // 输出堆栈信息
    if (stackTrace != null && level == LogLevel.error) {
      debugPrint('  StackTrace:\n${_formatStackTrace(stackTrace)}');
    }

    // 异步写入数据库（不阻塞主线程）
    _persistToDatabase(level, message, tag, data, stackTrace);
  }

  /// 异步持久化日志到数据库
  void _persistToDatabase(
    LogLevel level,
    String message,
    String? tag,
    Object? data,
    StackTrace? stackTrace,
  ) {
    // none 级别不持久化
    if (level == LogLevel.none) return;

    // 只有数据库日志器已初始化时才持久化
    try {
      final dbLogger = db_logger.AppLogger.instance;
      final extraData = data?.toString();
      dbLogger.log(
        level,
        tag ?? 'App',
        message,
        stackTrace,
        extraData,
      );
    } catch (_) {
      // 数据库日志器未初始化或写入失败，静默忽略
    }
  }

  /// 获取调用者信息
  String? _getCaller() {
    try {
      final trace = StackTrace.current.toString().split('\n');
      // 跳过 Logger 内部的调用栈
      for (var i = 0; i < trace.length; i++) {
        final line = trace[i];
        if (!line.contains('logger_service.dart') &&
            !line.contains('package:flutter') &&
            line.contains('.dart')) {
          // 提取文件名和行号
          final match = RegExp(r'(\w+\.dart):(\d+)').firstMatch(line);
          if (match != null) {
            return '${match.group(1)}:${match.group(2)}';
          }
        }
      }
    } catch (_) {}
    return null;
  }

  /// 格式化堆栈信息
  String _formatStackTrace(StackTrace stackTrace) {
    final lines = stackTrace.toString().split('\n');
    final buffer = StringBuffer();
    var count = 0;
    for (final line in lines) {
      if (line.trim().isNotEmpty && count < 10) {
        buffer.writeln('    $line');
        count++;
      }
    }
    return buffer.toString();
  }
}

/// 便捷的全局日志函数
Logger get logger => Logger.instance;

/// 快捷方法
void logDebug(String message, {String? tag, Object? data}) {
  logger.debug(message, tag: tag, data: data);
}

void logInfo(String message, {String? tag, Object? data}) {
  logger.info(message, tag: tag, data: data);
}

void logWarning(String message, {String? tag, Object? data}) {
  logger.warning(message, tag: tag, data: data);
}

void logError(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
  logger.error(message, tag: tag, error: error, stackTrace: stackTrace);
}
