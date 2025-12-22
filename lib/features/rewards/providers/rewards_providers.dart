import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';
import 'package:children_rewards/shared/providers/pagination_provider.dart';
import 'package:children_rewards/features/rewards/data/rewards_repository.dart';

/// 奖励仓库 Provider
final rewardsRepositoryProvider = Provider<RewardsRepository>((ref) {
  return RewardsRepository(ref.watch(databaseProvider));
});

/// 奖励流 Provider
final rewardsStreamProvider = StreamProvider.family<List<Reward>, String?>((ref, category) {
  return ref.watch(rewardsRepositoryProvider).watchRewards(category: category);
});

/// 奖励分页过滤器
class RewardsFilter {
  final String? category;
  final bool activeOnly;

  const RewardsFilter({this.category, this.activeOnly = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RewardsFilter && category == other.category && activeOnly == other.activeOnly;

  @override
  int get hashCode => Object.hash(category, activeOnly);
}

/// 奖励分页 Notifier
class RewardsPaginationNotifier extends PaginationNotifier<Reward, RewardsFilter> {
  final RewardsRepository _repository;

  RewardsPaginationNotifier(this._repository) : super(pageSize: 20);

  @override
  Future<List<Reward>> fetchPage(int page, int pageSize, RewardsFilter? filter) {
    return _repository.getRewardsPaged(
      category: filter?.category,
      activeOnly: filter?.activeOnly,
      limit: pageSize,
      offset: page * pageSize,
    );
  }
}

/// 奖励管理分页 Provider（显示所有奖励）
final rewardsPaginationProvider =
    StateNotifierProvider.autoDispose<RewardsPaginationNotifier, PaginationState<Reward>>((ref) {
  final repository = ref.watch(rewardsRepositoryProvider);
  return RewardsPaginationNotifier(repository);
});

/// 奖励商店分页 Provider（仅显示已启用的奖励）
final rewardsStorePaginationProvider =
    StateNotifierProvider.autoDispose<RewardsPaginationNotifier, PaginationState<Reward>>((ref) {
  final repository = ref.watch(rewardsRepositoryProvider);
  return RewardsPaginationNotifier(repository);
});
