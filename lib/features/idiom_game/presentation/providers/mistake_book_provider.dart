import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/features/idiom_game/providers/idiom_game_providers.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_engagement_dao.dart';

// Stats Provider (Keep as FutureProvider, simple fetch)
final mistakeStatsProvider = FutureProvider.family<MistakeStats, int>((ref, childId) async {
  final dao = ref.watch(idiomEngagementDaoProvider);
  return dao.getMistakeStats(childId);
});

// List State
class MistakeListState {
  final List<MistakeDetail> items;
  final bool isLoading;
  final bool hasMore;
  
  MistakeListState({
    this.items = const [],
    this.isLoading = false,
    this.hasMore = true,
  });
}

// List Notifier
class MistakeListNotifier extends StateNotifier<MistakeListState> {
  final IdiomEngagementDao _dao;
  final int _childId;
  static const int _pageSize = 20;

  MistakeListNotifier(this._dao, this._childId) : super(MistakeListState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = MistakeListState(isLoading: true);
    try {
      final items = await _dao.getMistakeList(_childId, limit: _pageSize, offset: 0);
      state = MistakeListState(
        items: items,
        isLoading: false,
        hasMore: items.length >= _pageSize,
      );
    } catch (e) {
      // In a real app, handle error state better
      state = MistakeListState(items: state.items, isLoading: false, hasMore: state.hasMore);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;
    
    // Set loading but keep existing items
    state = MistakeListState(items: state.items, isLoading: true, hasMore: state.hasMore);
    
    try {
      final offset = state.items.length;
      final newItems = await _dao.getMistakeList(_childId, limit: _pageSize, offset: offset);
      
      state = MistakeListState(
        items: [...state.items, ...newItems],
        isLoading: false,
        hasMore: newItems.length >= _pageSize,
      );
    } catch (e) {
      state = MistakeListState(items: state.items, isLoading: false, hasMore: state.hasMore);
    }
  }
}

// List Provider
final mistakeListProvider = StateNotifierProvider.family<MistakeListNotifier, MistakeListState, int>((ref, childId) {
  final dao = ref.watch(idiomEngagementDaoProvider);
  return MistakeListNotifier(dao, childId);
});