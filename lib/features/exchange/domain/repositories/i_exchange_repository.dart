import 'package:children_rewards/core/database/app_database.dart';

/// 兑换数据仓库接口
///
/// 定义兑换操作的抽象
abstract class IExchangeRepository {
  /// 监听兑换记录流
  Stream<List<Exchange>> watchExchanges(int childId);

  /// 执行商品兑换事务
  ///
  /// 包含完整的业务校验：
  /// - 奖励是否激活
  /// - 积分是否充足
  /// - 库存是否充足
  ///
  /// 抛出 [InsufficientFundsException] 当积分不足
  /// 抛出 [OutOfStockException] 当库存不足
  /// 抛出 [RewardInactiveException] 当奖励未激活
  Future<void> exchangeReward({
    required int childId,
    required int rewardId,
    String? note,
  });
}
