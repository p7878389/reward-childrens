import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/exceptions/app_exceptions.dart';
import 'package:children_rewards/features/exchange/domain/repositories/i_exchange_repository.dart';

/// 兑换数据仓库实现
class ExchangeRepository implements IExchangeRepository {
  final AppDatabase _db;

  ExchangeRepository(this._db);

  @override
  Stream<List<Exchange>> watchExchanges(int childId) {
    return (_db.select(_db.exchanges)
          ..where((t) => t.childId.equals(childId) & t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)]))
        .watch();
  }

  @override
  Future<void> exchangeReward({
    required int childId,
    required int rewardId,
    String? note,
  }) async {
    return _db.transaction(() async {
      final now = DateTime.now();

      // 1. 检查商品状态
      final reward = await (_db.select(_db.rewards)
            ..where((t) => t.id.equals(rewardId)))
          .getSingleOrNull();

      if (reward == null) throw AppException('Reward not found');
      if (!reward.isActive) throw RewardInactiveException();

      // 2. 检查宝贝余额
      final child = await (_db.select(_db.children)
            ..where((t) => t.id.equals(childId)))
          .getSingleOrNull();

      if (child == null) throw AppException('Child not found');
      if (child.stars < reward.price) throw InsufficientFundsException();

      // 3. 扣减库存（原子操作）
      if (reward.stock != null) {
        // 尝试更新：只有当库存 > 0 时才扣减
        final rowsUpdated = await (_db.update(_db.rewards)
              ..where((t) => t.id.equals(rewardId) & t.stock.isBiggerThanValue(0)))
            .write(RewardsCompanion(stock: Value(reward.stock! - 1)));

        if (rowsUpdated == 0) {
          // 更新失败意味着库存不足（或记录被删除）
          throw OutOfStockException();
        }
      }

      // 4. 创建兑换记录
      final exchangeId = await _db.into(_db.exchanges).insert(ExchangesCompanion.insert(
            childId: childId,
            rewardId: rewardId,
            rewardSnapshot: reward.name,
            pointsSpent: reward.price,
            note: Value(note),
            createdAt: now,
          ));

      // 5. 扣减积分 (也可以加 check 保证非负，虽然我们在 tables.dart 加了约束)
      // 使用原子更新防止并发修改
      // UPDATE children SET stars = stars - price WHERE id = childId
      // Drift custom statement is safer for relative updates
      await _db.customUpdate(
        'UPDATE children SET stars = stars - ?, updated_at = ? WHERE id = ?',
        variables: [Variable(reward.price), Variable(now.millisecondsSinceEpoch), Variable(childId)],
        updates: {_db.children},
      );

      // 6. 创建积分流水
      await _db.into(_db.pointRecords).insert(PointRecordsCompanion.insert(
            childId: childId,
            exchangeId: Value(exchangeId),
            ruleName: const Value('Exchange'), // 兑换
            points: -reward.price, // 负数表示消费
            type: 'spent',
            note: Value(reward.name), // 商品名称作为备注
            createdAt: now,
          ));
    });
  }
}
