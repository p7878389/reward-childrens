import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';
import 'package:children_rewards/features/points/providers/point_records_providers.dart';
import 'package:children_rewards/features/points/presentation/widgets/history_stats_card.dart';
import 'package:children_rewards/features/points/presentation/screens/add_record_screen.dart';
import 'package:children_rewards/features/rule/utils/rule_localization.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/shared/providers/pagination_provider.dart';

class PointsHistoryScreen extends ConsumerStatefulWidget {
  final int childId;

  const PointsHistoryScreen({super.key, required this.childId});

  @override
  ConsumerState<PointsHistoryScreen> createState() =>
      _PointsHistoryScreenState();
}

class _PointsHistoryScreenState extends ConsumerState<PointsHistoryScreen> {
  String _filter = 'all'; // all, earned, spent
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // 初始加载
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pointRecordsPaginationProvider.notifier).refresh(
            PointRecordsFilter(widget.childId, _filter),
          );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(pointRecordsPaginationProvider.notifier).loadMore();
    }
  }

  void _switchFilter(String filter) {
    if (_filter != filter) {
      setState(() => _filter = filter);
      ref.read(pointRecordsPaginationProvider.notifier).refresh(
            PointRecordsFilter(widget.childId, filter),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final paginationState = ref.watch(pointRecordsPaginationProvider);
    final statsAsync = ref.watch(pointStatsFutureProvider(widget.childId));
    final childAsync = ref.watch(allChildrenStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: () => Navigator.pop(context)),
                    const SizedBox.shrink(),
                    HeaderButton(
                        icon: Icons.add_rounded,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddRecordScreen(childId: widget.childId),
                            ),
                          );
                          // 返回后刷新
                          ref
                              .read(pointRecordsPaginationProvider.notifier)
                              .refresh(
                                PointRecordsFilter(widget.childId, _filter),
                              );
                        }),
                  ],
                ),
              ),
            ),

            // Stats Section
            SliverToBoxAdapter(
              child: statsAsync.when(
                data: (stats) {
                  int balance = 0;
                  if (childAsync.hasValue) {
                    try {
                      final child = childAsync.value!
                          .firstWhere((c) => c.id == widget.childId);
                      balance = child.stars;
                    } catch (_) {}
                  }
                  return HistoryStatsCard(
                    earned: stats['earned']!,
                    spent: stats['spent']!,
                    balance: balance,
                    labelBalance: l10n.totalBalance,
                    labelEarned: l10n.totalEarned,
                    labelDeducted: l10n.totalDeducted,
                  );
                },
                loading: () => const Center(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator())),
                error: (err, _) => Center(child: Text('Stats Error: $err')),
              ),
            ),

            // Filters
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: CommonFilterTabs(
                  selectedValue: _filter,
                  onSelect: _switchFilter,
                  tabs: [
                    FilterTabData(label: l10n.all, value: 'all'),
                    FilterTabData(label: l10n.earned, value: 'earned'),
                    FilterTabData(label: l10n.spent, value: 'spent'),
                  ],
                ),
              ),
            ),

            // Timeline List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: _buildRecordsList(paginationState, l10n),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordsList(
      PaginationState<PointRecord> state, AppLocalizations l10n) {
    if (state.items.isEmpty && !state.isLoading) {
      return const SliverEmptyState(icon: Icons.history_rounded);
    }

    if (state.items.isEmpty && state.isLoading) {
      return const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()));
    }

    // 按日期分组
    final grouped = <String, List<PointRecord>>{};
    for (var record in state.items) {
      final dateKey = _formatDate(record.createdAt, l10n);
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(record);
    }

    final dateKeys = grouped.keys.toList();
    final totalCount = dateKeys.length + (state.hasMore ? 1 : 0);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == dateKeys.length) {
            // 加载指示器
            return Padding(
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
          final dateKey = dateKeys[index];
          final dayRecords = grouped[dateKey]!;
          return _buildDaySection(dateKey, dayRecords, l10n);
        },
        childCount: totalCount,
      ),
    );
  }

  Widget _buildDaySection(
      String dateKey, List<PointRecord> records, AppLocalizations l10n) {
    return Stack(
      children: [
        Positioned(
          left: 5,
          top: 0,
          bottom: 0,
          child: Container(width: 2, color: AppColors.primary.withOpacity(0.2)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    border: Border.all(color: AppColors.background, width: 2),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  dateKey.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary.withOpacity(0.6),
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...records.map((record) => _buildRecordItem(record, l10n)),
            const SizedBox(height: 24),
          ],
        ),
      ],
    );
  }

  Widget _buildRecordItem(PointRecord record, AppLocalizations l10n) {
    final isEarned = record.type == 'earned';

    // 获得为绿色，支出（兑换或惩罚）均为红色
    final Color bgColor =
        isEarned ? const Color(0xFFF0FDF4) : const Color(0xFFFEF2F2);
    final Color iconBg =
        isEarned ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2);

    final IconData icon = isEarned
        ? Icons.check_circle_outline
        : (record.type == 'spent'
            ? Icons.shopping_bag_outlined
            : Icons.warning_amber_rounded);

    final String sign = isEarned ? '+' : '';
    final Color amountColor =
        isEarned ? const Color(0xFF16A34A) : const Color(0xFFDC2626);

    return Container(
      margin: const EdgeInsets.only(left: 16, bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
              color: AppColors.primary.withOpacity(0.05), spreadRadius: 1),
          BoxShadow(
              color: AppColors.textMain.withOpacity(0.03),
              offset: const Offset(0, 4),
              blurRadius: 14),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: iconBg, borderRadius: BorderRadius.circular(22)),
            child: Icon(icon, size: 24, color: amountColor.withOpacity(0.7)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizeRuleName(record.ruleName, l10n),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain),
                ),
                if (record.note != null && record.note!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    record.note!,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded,
                        size: 10,
                        color: AppColors.textSecondary.withOpacity(0.6)),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(record.createdAt),
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary.withOpacity(0.6)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$sign${record.points}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: amountColor),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) return l10n.today;
    if (dateOnly == yesterday) return l10n.yesterday;
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
