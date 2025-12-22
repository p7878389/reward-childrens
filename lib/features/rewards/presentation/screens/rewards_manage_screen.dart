import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/rewards/providers/rewards_providers.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/shared/providers/pagination_provider.dart';
import 'package:children_rewards/features/rewards/presentation/screens/add_reward_screen.dart';
import 'package:children_rewards/features/rewards/presentation/screens/edit_reward_screen.dart';

class RewardsManageScreen extends ConsumerStatefulWidget {
  const RewardsManageScreen({super.key});

  @override
  ConsumerState<RewardsManageScreen> createState() => _RewardsManageScreenState();
}

class _RewardsManageScreenState extends ConsumerState<RewardsManageScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // 初始加载
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(rewardsPaginationProvider.notifier).refresh(const RewardsFilter());
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
      ref.read(rewardsPaginationProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final paginationState = ref.watch(rewardsPaginationProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderButton(icon: Icons.arrow_back_ios_new_rounded, onTap: () => Navigator.pop(context)),
                  Text(
                    l10n.manageRewards.toUpperCase(),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1.1),
                  ),
                  HeaderButton(icon: Icons.add_rounded, onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddRewardScreen()),
                    );
                    // 返回后刷新列表
                    ref.read(rewardsPaginationProvider.notifier).refresh(const RewardsFilter());
                  }),
                ],
              ),
            ),

            Expanded(
              child: _buildRewardsList(paginationState, l10n),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsList(PaginationState<Reward> state, AppLocalizations l10n) {
    if (state.items.isEmpty && !state.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: AppColors.textSecondary.withOpacity(0.2)),
          ],
        ),
      );
    }

    if (state.items.isEmpty && state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(rewardsPaginationProvider.notifier).refresh(const RewardsFilter());
      },
      color: AppColors.primary,
      child: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: state.items.length + (state.hasMore ? 2 : 0), // 加载指示器占两格
      itemBuilder: (context, index) {
        if (index >= state.items.length) {
          if (index == state.items.length) {
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
          return const SizedBox.shrink();
        }
        final reward = state.items[index];
        return _buildRewardCard(context, reward, l10n);
      },
      ),
    );
  }

  Widget _buildRewardCard(BuildContext context, Reward reward, AppLocalizations l10n) {
    final isActive = reward.isActive;
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditRewardScreen(reward: reward)),
        );
        // 返回后刷新列表
        ref.read(rewardsPaginationProvider.notifier).refresh(const RewardsFilter());
      },
      child: Opacity(
        opacity: isActive ? 1.0 : 0.6,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: AppColors.primary.withOpacity(0.05), spreadRadius: 1),
              BoxShadow(color: AppColors.textMain.withOpacity(0.02), offset: const Offset(0, 4), blurRadius: 10),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Area
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      child: _buildRewardIcon(reward),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2)),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, size: 18, color: Color(0xFFD97706)),
                            const SizedBox(width: 4),
                            Text(
                              reward.price.toString(),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFFD97706)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content Area
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.textSecondary.withOpacity(0.1)),
                          ),
                          child: Text(
                            _getLocalizedCategory(reward.category, l10n).toUpperCase(),
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textSecondary.withOpacity(0.8)),
                          ),
                        ),
                        if (reward.stock != null)
                          Row(
                            children: [
                              Icon(Icons.inventory_2_outlined, size: 12, color: AppColors.textSecondary.withOpacity(0.6)),
                              const SizedBox(width: 2),
                              Text(
                                reward.stock.toString(),
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary.withOpacity(0.6)),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      reward.name,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textMain, height: 1.2),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Consistent height for description (2 lines)
                    SizedBox(
                      height: 32,
                      child: Text(
                        reward.description ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary.withOpacity(0.8),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardIcon(Reward reward) {
    if (reward.image != null) {
      final file = File(reward.image!);
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(file, fit: BoxFit.cover),
        );
      }
    }
    return const Icon(Icons.card_giftcard_rounded, color: Color(0xFFD97706), size: 28);
  }

  String _getLocalizedCategory(String category, AppLocalizations l10n) {
    switch (category) {
      case 'privileges': return l10n.privileges;
      case 'toys': return l10n.toys;
      case 'snacks': return l10n.snacks;
      default: return l10n.all;
    }
  }
}
