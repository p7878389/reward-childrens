/// 日志级别枚举
///
/// 统一的日志级别定义，用于服务层日志输出和数据库持久化
enum LogLevel {
  debug(0, 'DEBUG', '🐛'),
  info(1, 'INFO', 'ℹ️'),
  warning(2, 'WARN', '⚠️'),
  error(3, 'ERROR', '❌'),
  none(4, 'NONE', '');

  final int value;
  final String label;
  final String emoji;

  const LogLevel(this.value, this.label, this.emoji);

  /// 获取日志级别显示名称
  String get displayName => label;

  /// 从字符串解析日志级别
  static LogLevel fromString(String value) {
    switch (value.toLowerCase()) {
      case 'debug':
        return LogLevel.debug;
      case 'info':
        return LogLevel.info;
      case 'warning':
      case 'warn':
        return LogLevel.warning;
      case 'error':
        return LogLevel.error;
      case 'none':
        return LogLevel.none;
      default:
        return LogLevel.info;
    }
  }
}
