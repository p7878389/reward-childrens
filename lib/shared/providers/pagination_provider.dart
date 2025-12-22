import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/services/logger_service.dart';

/// 分页状态
class PaginationState<T> {
  final List<T> items;
  final bool isLoading;
  final bool hasMore;
  final int page;
  final String? error;

  const PaginationState({
    this.items = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.page = 0,
    this.error,
  });

  PaginationState<T> copyWith({
    List<T>? items,
    bool? isLoading,
    bool? hasMore,
    int? page,
    String? error,
  }) {
    return PaginationState<T>(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      error: error,
    );
  }
}

/// 分页 Notifier 基类
abstract class PaginationNotifier<T, F> extends StateNotifier<PaginationState<T>> {
  final int pageSize;
  F? _currentFilter;

  PaginationNotifier({this.pageSize = 20}) : super(const PaginationState());

  F? get currentFilter => _currentFilter;

  /// 子类实现具体的数据加载逻辑
  Future<List<T>> fetchPage(int page, int pageSize, F? filter);

  /// 初始化或刷新数据
  Future<void> refresh([F? filter]) async {
    _currentFilter = filter;
    state = state.copyWith(isLoading: true, error: null);

    try {
      final items = await fetchPage(0, pageSize, filter);
      state = PaginationState<T>(
        items: items,
        isLoading: false,
        hasMore: items.length >= pageSize,
        page: 0,
      );
    } catch (e, stackTrace) {
      logError('分页刷新失败', tag: 'PaginationNotifier', error: e, stackTrace: stackTrace);
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// 加载更多
  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final nextPage = state.page + 1;
      final newItems = await fetchPage(nextPage, pageSize, _currentFilter);
      state = state.copyWith(
        items: [...state.items, ...newItems],
        isLoading: false,
        hasMore: newItems.length >= pageSize,
        page: nextPage,
      );
    } catch (e, stackTrace) {
      logError('加载更多失败', tag: 'PaginationNotifier', error: e, stackTrace: stackTrace);
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// 更新过滤条件并刷新
  Future<void> updateFilter(F filter) async {
    if (_currentFilter != filter) {
      await refresh(filter);
    }
  }
}
