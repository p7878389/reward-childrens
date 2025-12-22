import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';
import 'package:children_rewards/shared/providers/pagination_provider.dart';
import 'package:children_rewards/features/points/data/point_records_repository.dart';
import 'package:children_rewards/features/rule/domain/usecases/apply_rule_usecase.dart';
import 'package:children_rewards/features/points/domain/models/point_record_detail.dart';

/// 积分记录过滤器
class PointRecordsFilter {
  final int childId;
  final String type; // all, earned, spent
  PointRecordsFilter(this.childId, this.type);

  @override
  bool operator ==(Object other) =>
      other is PointRecordsFilter && other.childId == childId && other.type == type;

  @override
  int get hashCode => Object.hash(childId, type);
}

/// 积分记录仓库 Provider
final pointRecordsRepositoryProvider = Provider<PointRecordsRepository>((ref) {
  return PointRecordsRepository(ref.watch(databaseProvider));
});

/// 积分记录流 Provider
final pointRecordsStreamProvider =
    StreamProvider.family<List<PointRecord>, PointRecordsFilter>((ref, filter) {
  final repo = ref.watch(pointRecordsRepositoryProvider);
  return repo.watchRecords(filter.childId, filterType: filter.type);
});

/// 积分统计 Provider
final pointStatsFutureProvider = FutureProvider.family<Map<String, int>, int>((ref, childId) {
  // 监听记录流变化，触发统计数据刷新
  ref.watch(pointRecordsStreamProvider(PointRecordsFilter(childId, 'all')));
  return ref.watch(pointRecordsRepositoryProvider).getStats(childId);
});

/// 积分记录分页 Notifier
class PointRecordsPaginationNotifier extends PaginationNotifier<PointRecordDetail, PointRecordsFilter> {
  final PointRecordsRepository _repository;

  PointRecordsPaginationNotifier(this._repository) : super(pageSize: 20);

  @override
  Future<List<PointRecordDetail>> fetchPage(int page, int pageSize, PointRecordsFilter? filter) {
    if (filter == null) return Future.value([]);
    return _repository.getRecordsPaged(
      childId: filter.childId,
      filterType: filter.type,
      limit: pageSize,
      offset: page * pageSize,
    );
  }
}

/// 积分记录分页 Provider
final pointRecordsPaginationProvider = StateNotifierProvider.autoDispose<
    PointRecordsPaginationNotifier, PaginationState<PointRecordDetail>>((ref) {
  final repository = ref.watch(pointRecordsRepositoryProvider);
  return PointRecordsPaginationNotifier(repository);
});

/// 应用规则用例 Provider
final applyRuleUseCaseProvider = Provider<ApplyRuleUseCase>((ref) {
  final repository = ref.watch(pointRecordsRepositoryProvider);
  return ApplyRuleUseCase(repository);
});
