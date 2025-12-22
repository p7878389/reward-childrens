import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:children_rewards/core/services/logger_service.dart';

/// 全局错误处理服务
class ErrorHandler {
  static bool _initialized = false;

  /// 初始化全局错误处理
  static void init() {
    if (_initialized) return;
    _initialized = true;

    // 捕获 Flutter 框架错误
    FlutterError.onError = _handleFlutterError;

    // 捕获 Platform Dispatcher 错误（Flutter 3.3+）
    PlatformDispatcher.instance.onError = _handlePlatformError;

    logInfo('ErrorHandler initialized', tag: 'ErrorHandler');
  }

  /// 处理 Flutter 框架错误
  static void _handleFlutterError(FlutterErrorDetails details) {
    logError(
      'Flutter Error: ${details.exceptionAsString()}',
      tag: 'FlutterError',
      error: details.exception,
      stackTrace: details.stack,
    );

    // 在调试模式下，仍然显示红屏
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    }
  }

  /// 处理平台错误
  static bool _handlePlatformError(Object error, StackTrace stackTrace) {
    logError(
      'Platform Error: $error',
      tag: 'PlatformError',
      error: error,
      stackTrace: stackTrace,
    );
    return true; // 返回 true 表示错误已处理
  }

  /// 在 Zone 中运行应用，捕获所有异步错误
  static void runAppWithErrorHandler(Widget app, {bool ensureInitialized = false}) {
    runZonedGuarded(
      () {
        if (ensureInitialized) {
          WidgetsFlutterBinding.ensureInitialized();
        }
        runApp(app);
      },
      (error, stackTrace) {
        logError(
          'Uncaught Error: $error',
          tag: 'ZoneError',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
  }

  /// 手动报告错误
  static void reportError(
    Object error, {
    StackTrace? stackTrace,
    String? context,
    Map<String, dynamic>? extra,
  }) {
    final message = context != null ? '$context: $error' : error.toString();
    logError(
      message,
      tag: 'ReportedError',
      error: error,
      stackTrace: stackTrace ?? StackTrace.current,
    );

    if (extra != null) {
      logDebug('Extra info: $extra', tag: 'ReportedError');
    }
  }

  /// 安全执行异步操作
  static Future<T?> safeAsync<T>(
    Future<T> Function() action, {
    String? context,
    T? fallback,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      return await action();
    } catch (e, stackTrace) {
      reportError(e, stackTrace: stackTrace, context: context);
      onError?.call(e, stackTrace);
      return fallback;
    }
  }

  /// 安全执行同步操作
  static T? safeSync<T>(
    T Function() action, {
    String? context,
    T? fallback,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    try {
      return action();
    } catch (e, stackTrace) {
      reportError(e, stackTrace: stackTrace, context: context);
      onError?.call(e, stackTrace);
      return fallback;
    }
  }
}

/// 扩展方法：为 Future 添加错误处理
extension SafeFutureExtension<T> on Future<T> {
  /// 安全执行 Future，捕获错误
  Future<T?> safe({String? context, T? fallback}) async {
    try {
      return await this;
    } catch (e, stackTrace) {
      ErrorHandler.reportError(e, stackTrace: stackTrace, context: context);
      return fallback;
    }
  }
}
