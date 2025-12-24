abstract class Result<T> {
  const Result();

  factory Result.success(T data) = Success<T>;
  factory Result.failure(String message, [Object? error, StackTrace? stackTrace]) = Failure<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(String message, Object? error, StackTrace? stackTrace) failure,
  });
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, Object? error, StackTrace? stackTrace) failure,
  }) {
    return success(data);
  }
}

class Failure<T> extends Result<T> {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  const Failure(this.message, [this.error, this.stackTrace]);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, Object? error, StackTrace? stackTrace) failure,
  }) {
    return failure(message, error, stackTrace);
  }
}