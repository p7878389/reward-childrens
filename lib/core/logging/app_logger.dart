import 'dart:async';
import 'dart:collection';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'log_level.dart';

/// 日志条目（内存中的日志对象）
class LogEntry {
  final LogLevel level;
  final String tag;
  final String message;
  final String? stackTrace;
  final String? extra;
  final DateTime createdAt;

  LogEntry({
    required this.level,
    required this.tag,
    required this.message,
    this.stackTrace,
    this.extra,
    required this.createdAt,
  });

  /// 转换为数据库 Companion 对象
  AppLogsCompanion toCompanion() {
    return AppLogsCompanion.insert(
      level: level.name,
      tag: tag,
      message: message,
      stackTrace: Value(stackTrace),
      extra: Value(extra),
      createdAt: createdAt,
    );
  }
}

/// 异步日志记录器（单例模式）
///
/// 特点：
/// - 日志先写入内存队列，主线程立即返回
/// - 定时批量异步写入数据库
/// - 队列满时自动触发写入
/// - 应用退出时强制刷新
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  static AppLogger get instance => _instance;

  AppLogger._internal();

  /// 内存日志队列
  final Queue<LogEntry> _queue = Queue();

  /// 定时刷新计时器
  Timer? _flushTimer;

  /// 是否正在刷新（防止并发）
  bool _isFlushing = false;

  /// 数据库实例（需要外部注入）
  AppDatabase? _database;

  /// 是否已初始化
  bool _initialized = false;

  /// 批量写入阈值
  static const int _batchSize = 50;

  /// 定时刷新间隔
  static const Duration _flushInterval = Duration(seconds: 2);

  /// 最低记录级别（低于此级别的日志将被忽略）
  LogLevel minLevel = kDebugMode ? LogLevel.debug : LogLevel.info;

  /// 是否同时输出到控制台
  bool enableConsoleOutput = kDebugMode;

  /// 初始化日志器
  void init(AppDatabase database) {
    if (_initialized) return;
    _database = database;
    _initialized = true;
    _startFlushTimer();

    // 启动时清理过期日志
    _cleanOldLogsAsync();
  }

  /// 启动定时刷新
  void _startFlushTimer() {
    _flushTimer?.cancel();
    _flushTimer = Timer.periodic(_flushInterval, (_) => _flush());
  }

  /// 异步清理过期日志
  void _cleanOldLogsAsync() {
    Future.microtask(() async {
      try {
        await _database?.cleanOldLogs(keepDays: 7);
      } catch (e) {
        // 清理失败不影响应用运行
        debugPrint('[AppLogger] Failed to clean old logs: $e');
      }
    });
  }

  /// 记录日志（同步添加到队列，立即返回）
  void log(LogLevel level, String tag, String message, [StackTrace? stack, String? extra]) {
    // 级别过滤
    if (level.index < minLevel.index) return;

    final entry = LogEntry(
      level: level,
      tag: tag,
      message: message,
      stackTrace: stack?.toString(),
      extra: extra,
      createdAt: DateTime.now(),
    );

    // 添加到队列
    _queue.add(entry);

    // 控制台输出
    if (enableConsoleOutput) {
      _printToConsole(entry);
    }

    // 队列满时触发异步写入
    if (_queue.length >= _batchSize) {
      _scheduleFlush();
    }
  }

  /// 控制台输出
  void _printToConsole(LogEntry entry) {
    final timestamp = _formatTime(entry.createdAt);
    final levelStr = entry.level.displayName.padRight(5);
    final tagStr = '[${entry.tag}]';

    debugPrint('$timestamp $levelStr $tagStr ${entry.message}');

    if (entry.stackTrace != null) {
      debugPrint(entry.stackTrace!);
    }
  }

  /// 格式化时间
  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
           '${time.minute.toString().padLeft(2, '0')}:'
           '${time.second.toString().padLeft(2, '0')}.'
           '${time.millisecond.toString().padLeft(3, '0')}';
  }

  /// 调度异步刷新
  void _scheduleFlush() {
    Future.microtask(() => _flush());
  }

  /// 异步批量写入数据库
  Future<void> _flush() async {
    if (_isFlushing || _queue.isEmpty || _database == null) return;
    _isFlushing = true;

    try {
      // 取出当前队列所有日志（最多 batchSize 条）
      final entries = <LogEntry>[];
      while (_queue.isNotEmpty && entries.length < _batchSize) {
        entries.add(_queue.removeFirst());
      }

      if (entries.isEmpty) return;

      // 转换为数据库对象并批量写入
      final companions = entries.map((e) => e.toCompanion()).toList();
      await _database!.insertLogsBatch(companions);
    } catch (e) {
      // 写入失败，日志已从队列移除，避免重复尝试导致内存溢出
      debugPrint('[AppLogger] Failed to flush logs: $e');
    } finally {
      _isFlushing = false;
    }
  }

  /// 应用退出时强制刷新所有日志
  Future<void> forceFlush() async {
    _flushTimer?.cancel();
    while (_queue.isNotEmpty) {
      await _flush();
    }
  }

  /// 释放资源
  void dispose() {
    _flushTimer?.cancel();
    _flushTimer = null;
  }

  // ==================== 便捷方法 ====================

  /// 调试日志
  void debug(String tag, String message, [String? extra]) {
    log(LogLevel.debug, tag, message, null, extra);
  }

  /// 信息日志
  void info(String tag, String message, [String? extra]) {
    log(LogLevel.info, tag, message, null, extra);
  }

  /// 警告日志
  void warning(String tag, String message, [String? extra]) {
    log(LogLevel.warning, tag, message, null, extra);
  }

  /// 错误日志
  void error(String tag, String message, [StackTrace? stackTrace, String? extra]) {
    log(LogLevel.error, tag, message, stackTrace, extra);
  }
}

/// 全局日志器实例（便捷访问）
final logger = AppLogger.instance;
