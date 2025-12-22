import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

/// 分页列表组件
class PaginatedListView<T> extends StatefulWidget {
  final List<T> items;
  final bool isLoading;
  final bool hasMore;
  final VoidCallback onLoadMore;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final double loadMoreThreshold;

  const PaginatedListView({
    super.key,
    required this.items,
    required this.isLoading,
    required this.hasMore,
    required this.onLoadMore,
    required this.itemBuilder,
    this.emptyWidget,
    this.loadingWidget,
    this.padding,
    this.controller,
    this.loadMoreThreshold = 200,
  });

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - widget.loadMoreThreshold) {
      if (!widget.isLoading && widget.hasMore) {
        widget.onLoadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty && !widget.isLoading) {
      return widget.emptyWidget ?? const SizedBox.shrink();
    }

    return ListView.builder(
      controller: _scrollController,
      padding: widget.padding,
      itemCount: widget.items.length + (widget.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.items.length) {
          return _buildLoadingIndicator();
        }
        return widget.itemBuilder(context, widget.items[index], index);
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return widget.loadingWidget ??
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary.withOpacity(0.5),
              ),
            ),
          ),
        );
  }
}

/// 分页网格组件
class PaginatedGridView<T> extends StatefulWidget {
  final List<T> items;
  final bool isLoading;
  final bool hasMore;
  final VoidCallback onLoadMore;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final SliverGridDelegate gridDelegate;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final double loadMoreThreshold;

  const PaginatedGridView({
    super.key,
    required this.items,
    required this.isLoading,
    required this.hasMore,
    required this.onLoadMore,
    required this.itemBuilder,
    required this.gridDelegate,
    this.emptyWidget,
    this.loadingWidget,
    this.padding,
    this.controller,
    this.loadMoreThreshold = 200,
  });

  @override
  State<PaginatedGridView<T>> createState() => _PaginatedGridViewState<T>();
}

class _PaginatedGridViewState<T> extends State<PaginatedGridView<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - widget.loadMoreThreshold) {
      if (!widget.isLoading && widget.hasMore) {
        widget.onLoadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty && !widget.isLoading) {
      return widget.emptyWidget ?? const SizedBox.shrink();
    }

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: widget.padding ?? EdgeInsets.zero,
          sliver: SliverGrid(
            gridDelegate: widget.gridDelegate,
            delegate: SliverChildBuilderDelegate(
              (context, index) => widget.itemBuilder(context, widget.items[index], index),
              childCount: widget.items.length,
            ),
          ),
        ),
        if (widget.hasMore)
          SliverToBoxAdapter(
            child: widget.loadingWidget ??
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
          ),
      ],
    );
  }
}

/// Sliver 分页列表（用于 CustomScrollView 中）
class SliverPaginatedList<T> extends StatelessWidget {
  final List<T> items;
  final bool isLoading;
  final bool hasMore;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? loadingWidget;

  const SliverPaginatedList({
    super.key,
    required this.items,
    required this.isLoading,
    required this.hasMore,
    required this.itemBuilder,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == items.length) {
            return loadingWidget ??
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                    ),
                  ),
                );
          }
          return itemBuilder(context, items[index], index);
        },
        childCount: items.length + (hasMore ? 1 : 0),
      ),
    );
  }
}
