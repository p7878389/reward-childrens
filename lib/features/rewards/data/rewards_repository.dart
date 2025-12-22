import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/features/rewards/domain/repositories/i_rewards_repository.dart';

/// 奖励数据仓库实现
class RewardsRepository implements IRewardsRepository {
  final AppDatabase _db;

  RewardsRepository(this._db);

  @override
  Stream<List<Reward>> watchRewards({String? category}) {
    var query = _db.select(_db.rewards)..where((t) => t.isDeleted.equals(false));

    if (category != null && category != 'All') {
      query = query..where((t) => t.category.equals(category.toLowerCase()));
    }

    return query.watch();
  }

  @override
  Future<List<Reward>> getRewardsPaged({
    String? category,
    required int limit,
    required int offset,
    bool? activeOnly,
  }) {
    var query = _db.select(_db.rewards)
      ..where((t) => t.isDeleted.equals(false))
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)])
      ..limit(limit, offset: offset);

    if (category != null && category != 'All') {
      query = query..where((t) => t.category.equals(category.toLowerCase()));
    }

    if (activeOnly == true) {
      query = query..where((t) => t.isActive.equals(true));
    }

    return query.get();
  }

  @override
  Future<int> getRewardsCount({String? category, bool? activeOnly}) async {
    final query = _db.selectOnly(_db.rewards)
      ..addColumns([_db.rewards.id.count()])
      ..where(_db.rewards.isDeleted.equals(false));

    if (category != null && category != 'All') {
      query.where(_db.rewards.category.equals(category.toLowerCase()));
    }

    if (activeOnly == true) {
      query.where(_db.rewards.isActive.equals(true));
    }

    final result = await query.getSingle();
    return result.read(_db.rewards.id.count()) ?? 0;
  }

  @override
  Future<int> createReward(RewardsCompanion companion) {
    return _db.into(_db.rewards).insert(companion);
  }

  @override
  Future<bool> updateReward(int id, RewardsCompanion companion) {
    return (_db.update(_db.rewards)..where((t) => t.id.equals(id))).write(companion).then((v) => v > 0);
  }

  @override
  Future<void> deleteReward(int id) {
    return (_db.update(_db.rewards)..where((t) => t.id.equals(id))).write(
      const RewardsCompanion(isDeleted: Value(true), isActive: Value(false)),
    );
  }

  @override
  Future<void> toggleRewardStatus(int id, bool isActive) {
    return (_db.update(_db.rewards)..where((t) => t.id.equals(id))).write(
      RewardsCompanion(isActive: Value(isActive)),
    );
  }
}
