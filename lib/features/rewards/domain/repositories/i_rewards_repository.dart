import 'package:children_rewards/core/database/app_database.dart';

/// 奖励数据仓库接口
///
/// 定义奖励数据的 CRUD 操作抽象
abstract class IRewardsRepository {
  /// 监听奖励列表
  Stream<List<Reward>> watchRewards({String? category});

  /// 分页查询奖励
  Future<List<Reward>> getRewardsPaged({
    String? category,
    required int limit,
    required int offset,
    bool? activeOnly,
  });

  /// 获取奖励总数
  Future<int> getRewardsCount({String? category, bool? activeOnly});

  /// 创建奖励
  Future<int> createReward(RewardsCompanion companion);

  /// 更新奖励
  Future<bool> updateReward(int id, RewardsCompanion companion);

  /// 删除奖励（软删除）
  Future<void> deleteReward(int id);

  /// 切换奖励状态
  Future<void> toggleRewardStatus(int id, bool isActive);
}
