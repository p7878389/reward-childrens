import 'result.dart';

/// UseCase 基础抽象类
///
/// 所有 UseCase 应该继承此类，实现 execute 方法。
/// UseCase 封装单一业务操作，遵循单一职责原则。
///
/// 类型参数：
/// - [Params]: 输入参数类型
/// - [Output]: 输出结果类型
abstract class UseCase<Params, Output> {
  /// 执行用例
  Future<Result<Output>> execute(Params params);

  /// 便捷调用方法
  Future<Result<Output>> call(Params params) => execute(params);
}

/// 无参数的 UseCase 基础类
abstract class NoParamsUseCase<Output> {
  /// 执行用例
  Future<Result<Output>> execute();

  /// 便捷调用方法
  Future<Result<Output>> call() => execute();
}

/// 流式 UseCase 基础类
///
/// 用于返回 Stream 的用例，如监听数据变化
abstract class StreamUseCase<Params, Output> {
  /// 执行用例，返回数据流
  Stream<Output> execute(Params params);

  /// 便捷调用方法
  Stream<Output> call(Params params) => execute(params);
}

/// 无参数的流式 UseCase 基础类
abstract class NoParamsStreamUseCase<Output> {
  /// 执行用例，返回数据流
  Stream<Output> execute();

  /// 便捷调用方法
  Stream<Output> call() => execute();
}
