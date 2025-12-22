import 'package:flutter/foundation.dart';

/// 操作结果封装类
///
/// 使用 sealed class 模式封装成功或失败的结果，
/// 提供类型安全的错误处理方式。
@immutable
sealed class Result<T> {
  const Result();

  /// 创建成功结果
  static Result<T> success<T>(T data) => Success<T>(data);

  /// 创建失败结果
  static Result<T> failure<T>(String message, {Exception? exception, StackTrace? stackTrace}) =>
      Failure<T>(message, exception: exception, stackTrace: stackTrace);

  /// 是否成功
  bool get isSuccess => this is Success<T>;

  /// 是否失败
  bool get isFailure => this is Failure<T>;

  /// 获取成功数据（如果失败则返回null）
  T? get dataOrNull => switch (this) {
        Success<T>(data: final data) => data,
        Failure<T>() => null,
      };

  /// 获取错误信息（如果成功则返回null）
  String? get errorOrNull => switch (this) {
        Success<T>() => null,
        Failure<T>(message: final msg) => msg,
      };

  /// 模式匹配处理结果
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, Exception? exception, StackTrace? stackTrace) failure,
  }) {
    return switch (this) {
      Success<T>(data: final data) => success(data),
      Failure<T>(message: final msg, exception: final ex, stackTrace: final st) => failure(msg, ex, st),
    };
  }

  /// 映射成功值
  Result<R> map<R>(R Function(T data) mapper) {
    return switch (this) {
      Success<T>(data: final data) => Result.success(mapper(data)),
      Failure<T>(message: final msg, exception: final ex, stackTrace: final st) =>
        Result.failure(msg, exception: ex, stackTrace: st),
    };
  }

  /// 扁平映射
  Future<Result<R>> flatMap<R>(Future<Result<R>> Function(T data) mapper) async {
    return switch (this) {
      Success<T>(data: final data) => await mapper(data),
      Failure<T>(message: final msg, exception: final ex, stackTrace: final st) =>
        Result.failure(msg, exception: ex, stackTrace: st),
    };
  }
}

/// 成功结果
@immutable
final class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Success<T> && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'Success($data)';
}

/// 失败结果
@immutable
final class Failure<T> extends Result<T> {
  final String message;
  final Exception? exception;
  final StackTrace? stackTrace;

  const Failure(this.message, {this.exception, this.stackTrace});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure<T> && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'Failure($message${stackTrace != null ? ', stackTrace: $stackTrace' : ''})';
}

/// 无数据的成功结果类型别名
typedef VoidResult = Result<void>;
