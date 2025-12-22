import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/constants/avatar_data.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';
import 'package:children_rewards/features/rewards/providers/rewards_providers.dart';
import 'package:children_rewards/features/rewards/presentation/widgets/reward_card.dart';
import 'package:children_rewards/features/rewards/presentation/screens/reward_detail_screen.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/shared/providers/pagination_provider.dart';

class RewardsStoreScreen extends ConsumerStatefulWidget {
  const RewardsStoreScreen({super.key});

  @override
  ConsumerState<RewardsStoreScreen> createState() => _RewardsStoreScreenState();
}

class _RewardsStoreScreenState extends ConsumerState<RewardsStoreScreen> {
  String? selectedCategory; // Null means 'All'
  int? _selectedChildId;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // 初始加载（仅显示已启用的奖励）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(rewardsStorePaginationProvider.notifier).refresh(
        const RewardsFilter(activeOnly: true),
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
      ref.read(rewardsStorePaginationProvider.notifier).loadMore();
    }
  }

  void _switchCategory(String? category) {
    final newCategory = category == 'All' ? null : category;
    if (selectedCategory != newCategory) {
      setState(() => selectedCategory = newCategory);
      ref.read(rewardsStorePaginationProvider.notifier).refresh(
        RewardsFilter(category: newCategory, activeOnly: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // UI 内部显示用的分类名列表
    final List<Map<String, String>> categories = [
      {'label': l10n.all, 'value': 'All'},
      {'label': l10n.privileges, 'value': 'privileges'},
      {'label': l10n.toys, 'value': 'toys'},
      {'label': l10n.snacks, 'value': 'snacks'},
    ];

    final allChildrenAsync = ref.watch(allChildrenStreamProvider);
    final paginationState = ref.watch(rewardsStorePaginationProvider);

    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40), // Placeholder for balance
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: AppColors.primary.withOpacity(0.1), spreadRadius: 1),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8, height: 8,
                        decoration: const BoxDecoration(color: Color(0xFF88C458), shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.rewardsStore.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),
        ),

        // Child Selector
        SliverToBoxAdapter(
          child: allChildrenAsync.when(
            data: (children) {
              if (children.isEmpty) return const SizedBox.shrink();

              // Initialize selection if needed
              if (_selectedChildId == null && children.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) setState(() => _selectedChildId = children.first.id);
                });
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children.map((child) => _buildChildItem(child)).toList(),
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ),

        // Category Filter
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: CommonFilterTabs(
              selectedValue: selectedCategory ?? 'All',
              onSelect: _switchCategory,
              tabs: categories.map((c) => FilterTabData(
                label: c['label']!,
                value: c['value']!,
              )).toList(),
            ),
          ),
        ),

        // Rewards Grid
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: _buildRewardsGrid(paginationState, l10n),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }

  Widget _buildRewardsGrid(PaginationState<Reward> state, AppLocalizations l10n) {
    if (state.items.isEmpty && !state.isLoading) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Icon(Icons.inventory_2_outlined, size: 64, color: AppColors.textSecondary.withOpacity(0.2)),
                const SizedBox(height: 16),
                Text(
                  l10n.noRecordsFound,
                  style: TextStyle(color: AppColors.textSecondary.withOpacity(0.5)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (state.items.isEmpty && state.isLoading) {
      return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
    }

    final itemCount = state.items.length + (state.hasMore ? 2 : 0); // 加载指示器占两格

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index >= state.items.length) {
            // 加载指示器
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
          return RewardCard(
            reward: reward,
            onTap: () {
              if (_selectedChildId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RewardDetailScreen(
                      reward: reward,
                      childId: _selectedChildId!,
                    ),
                  ),
                );
              }
            },
          );
        },
        childCount: itemCount,
      ),
    );
  }

  Widget _buildChildItem(ChildrenData child) {
    final isSelected = _selectedChildId == child.id;
    final size = isSelected ? 80.0 : 64.0;

    return GestureDetector(
      onTap: () => setState(() => _selectedChildId = child.id),
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: Container(
                    width: size, height: size,
                    decoration: const BoxDecoration(
                      color: AppColors.blueTag,
                      shape: BoxShape.circle,
                    ),
                    child: RepaintBoundary(
                      child: ClipOval(
                        child: _buildAvatarImage(child.avatar, size: size),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -2,
                  right: -6,
                  child: StarBadge(
                    count: child.stars,
                    avatarSize: size,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              child.name,
              style: TextStyle(
                fontSize: isSelected ? 14 : 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.textMain : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarImage(String? avatarPath, {double size = 48}) {
    if (avatarPath == null) return const Icon(Icons.person, color: Colors.white);
    if (avatarPath.startsWith('builtin:')) {
      final index = int.tryParse(avatarPath.split(':')[1]) ?? 0;
      return SvgPicture.string(
        AvatarData.builtInSvgs[index % AvatarData.builtInSvgs.length],
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
    }
    return Image.file(
      File(avatarPath),
      fit: BoxFit.cover,
      width: size,
      height: size,
      errorBuilder: (_, __, ___) => const Icon(Icons.person, color: Colors.white),
    );
  }
}
