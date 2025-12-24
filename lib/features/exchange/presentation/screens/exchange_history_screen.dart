import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/exchange/providers/exchange_providers.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';
import 'package:children_rewards/features/points/providers/point_records_providers.dart';
import 'package:children_rewards/features/points/presentation/widgets/history_stats_card.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';

class ExchangeHistoryScreen extends ConsumerWidget {
  final int childId;

  const ExchangeHistoryScreen({super.key, required this.childId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final exchangesAsync = ref.watch(exchangesStreamProvider(childId));
    final childAsync = ref.watch(childStreamProvider(childId));
    final statsAsync = ref.watch(pointStatsFutureProvider(childId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: AppHeader(
                title: l10n.rewardHistory,
                dotColor: const Color(0xFFF59E0B),
              ),
            ),

            // Child Info Section
            SliverToBoxAdapter(
              child: childAsync.when(
                data: (child) => child != null
                    ? _buildChildHeader(context, child, l10n)
                    : const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Stats Section
            SliverToBoxAdapter(
              child: exchangesAsync.when(
                data: (exchanges) {
                  return statsAsync.when(
                    data: (stats) {
                      final totalSpent = stats['spent'] ?? 0;
                      final totalEarned = stats['earned'] ?? 0;
                      final totalItems = exchanges.length;

                      return HistoryStatsCard(
                        earned: totalEarned,
                        spent: totalSpent,
                        balance: totalItems,
                        labelBalance: l10n.totalItems,
                        labelEarned: l10n.totalEarned,
                        labelDeducted: l10n.totalSpent,
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, _) => Center(child: Text('Stats Error: $err')),
                  );
                },
                loading: () => const Center(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator())),
                error: (err, _) => Center(child: Text('Exchanges Error: $err')),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Timeline List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: exchangesAsync.when(
                data: (exchanges) {
                  if (exchanges.isEmpty) {
                    return const SliverEmptyState(
                      icon: Icons.history_rounded,
                    );
                  }

                  final grouped = <String, List<Exchange>>{};
                  for (var exchange in exchanges) {
                    final dateKey = _formatDate(exchange.createdAt, l10n);
                    if (!grouped.containsKey(dateKey)) {
                      grouped[dateKey] = [];
                    }
                    grouped[dateKey]!.add(exchange);
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final dateKey = grouped.keys.elementAt(index);
                        final dayExchanges = grouped[dateKey]!;
                        return _buildDaySection(dateKey, dayExchanges);
                      },
                      childCount: grouped.keys.length,
                    ),
                  );
                },
                loading: () => const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator())),
                error: (err, stack) =>
                    SliverToBoxAdapter(child: Text('Error: $err')),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildChildHeader(
      BuildContext context, ChildrenData child, AppLocalizations l10n) {
    // Age calculation
    String ageText = "";
    if (child.birthday != null) {
      try {
        final birthDate = DateTime.parse(child.birthday!);
        final age = DateTime.now().year - birthDate.year;
        ageText = "$age ${l10n.years.toLowerCase()}";
      } catch (_) {}
    }

    final genderIcon =
        child.gender == 'boy' ? Icons.male_rounded : Icons.female_rounded;
    final genderColor = child.gender == 'boy' ? Colors.blue : Colors.pink;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: AppColors.textMain.withValues(alpha: 0.03),
                offset: const Offset(0, 4),
                blurRadius: 12),
          ],
        ),
                child: Row(
                  children: [
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.blueTag,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 3),
                        boxShadow: [
                          BoxShadow(color: AppColors.primary.withValues(alpha: 0.15), offset: const Offset(0, 4), blurRadius: 12),
                        ],
                      ),
                      child: AvatarImage(
                        avatar: child.avatar,
                        fallbackText: child.name,
                        size: 80,
                      ),
                    ),
                    const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    child.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMain),
                  ),
                  const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        _buildInfoTag(
                                          icon: genderIcon,
                                          text: child.gender == 'boy' ? l10n.boy : l10n.girl,
                                          color: genderColor,
                                          bgColor: child.gender == 'boy' ? const Color(0xFFEFF6FF) : const Color(0xFFFFF1F2),
                                        ),
                                        if (ageText.isNotEmpty) ...[
                                          const SizedBox(width: 8),
                                          _buildInfoTag(
                                            icon: Icons.cake_rounded,
                                            text: ageText,
                                            color: AppColors.textSecondary,
                                            bgColor: const Color(0xFFF1F5F9),
                                          ),
                                        ],
                                      ],
                                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTag({
    required IconData icon,
    required String text,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: color.withValues(alpha: 0.8),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySection(String dateKey, List<Exchange> exchanges) {
    return Stack(
      children: [
        Positioned(
          left: 5,
          top: 0,
          bottom: 0,
          child: Container(width: 2, color: AppColors.primary.withValues(alpha: 0.2)),
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
                    color: AppColors.textSecondary.withValues(alpha: 0.6),
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...exchanges.map((exchange) => _buildExchangeItem(exchange)),
            const SizedBox(height: 24),
          ],
        ),
      ],
    );
  }

  Widget _buildExchangeItem(Exchange exchange) {
    return Container(
      margin: const EdgeInsets.only(left: 16, bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.05), spreadRadius: 1),
          BoxShadow(
              color: AppColors.textMain.withValues(alpha: 0.03),
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
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(22)),
            child: const Icon(Icons.card_giftcard_rounded,
                size: 24, color: Color(0xFFD97706)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exchange.rewardSnapshot,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(exchange.createdAt),
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '-${exchange.pointsSpent}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFD97706)),
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
    return DateFormat('MMM d, yyyy').format(date);
  }
}
