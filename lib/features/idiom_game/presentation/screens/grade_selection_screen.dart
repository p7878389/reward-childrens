import 'package:children_rewards/features/children/presentation/screens/add_child_screen.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/idiom_game/presentation/screens/idiom_game_screen.dart';
import 'package:children_rewards/features/idiom_game/presentation/screens/game_settings_screen.dart';
import 'package:children_rewards/features/idiom_game/providers/idiom_game_providers.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';
import 'package:children_rewards/core/database/app_database.dart';

class GradeSelectionScreen extends ConsumerWidget {
  final int childId;

  const GradeSelectionScreen({super.key, required this.childId});

  String _getGradeName(int grade) {
    if (grade >= 1 && grade <= 6) {
      const names = ["一", "二", "三", "四", "五", "六"];
      return "${names[grade - 1]}年级";
    } else if (grade >= 7 && grade <= 9) {
      const names = ["一", "二", "三"];
      return "初${names[grade - 7]}";
    } else if (grade >= 10 && grade <= 12) {
      const names = ["一", "二", "三"];
      return "高${names[grade - 10]}";
    }
    return "第 $grade 级";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final progressAsync = ref.watch(idiomGradeProgressProvider(childId));
    final childrenAsync = ref.watch(allChildrenStreamProvider);
    final topPadding = MediaQuery.paddingOf(context).top;
    
    return childrenAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
      data: (children) {
        if (children.isEmpty) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: topPadding + 60)),
                SliverEmptyState(
                  icon: Icons.child_care_rounded,
                  message: "暂无宝贝档案",
                  description: "添加宝贝后即可开始成语挑战之旅",
                  actionText: "添加宝贝",
                  onAction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddChildScreen()),
                    );
                  },
                ),
              ],
            ),
          );
        }

        // Find current child
        final currentChild = children.any((c) => c.id == childId)
            ? children.firstWhere((c) => c.id == childId)
            : children.first;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: progressAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (progressList) {
                final progressMap = {for (var p in progressList) p.grade: p};
                
                int currentHighestGrade = 1;
                for (var p in progressList) {
                  if (p.isUnlocked && p.grade > currentHighestGrade) {
                    currentHighestGrade = p.grade;
                  }
                }

                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // Unified Header
                    SliverToBoxAdapter(
                      child: AppHeader(
                        title: l10n.idiomGame,
                      ),
                    ),

                    // Child Card
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                        child: _buildChildCard(context, ref, currentChild, children),
                      ),
                    ),

                    // 闯关挑战 Section Title
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                        child: Row(
                          children: [
                            Text(
                              "闯关挑战",
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: AppColors.textMain,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "解锁进度: $currentHighestGrade/12",
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 闯关 Levels Grid
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final grade = index + 1;
                            final progress = progressMap[grade];
                            final isUnlocked = progress?.isUnlocked ?? (grade == 1);
                            final isCurrent = grade == currentHighestGrade;
                            final stars = progress?.starRating ?? 0;

                            return _LevelCard(
                              grade: grade,
                              gradeName: _getGradeName(grade),
                              isUnlocked: isUnlocked,
                              isCurrent: isCurrent,
                              stars: stars,
                              onTap: isUnlocked
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => IdiomGameScreen(
                                            childId: currentChild.id,
                                            grade: grade,
                                          ),
                                        ),
                                      ).then((_) {
                                        ref.invalidate(idiomGradeProgressProvider(currentChild.id));
                                      });
                                    }
                                  : null,
                            );
                          },
                          childCount: 12,
                        ),
                      ),
                    ),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  /// 方块卡片展示儿童信息
  Widget _buildChildCard(BuildContext context, WidgetRef ref, ChildrenData currentChild, List<ChildrenData> allChildren) {
    String ageText = "";
    if (currentChild.birthday != null) {
      try {
        final birthDate = DateTime.parse(currentChild.birthday!);
        final age = DateTime.now().year - birthDate.year;
        ageText = "$age岁";
      } catch (_) {}
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.textMain.withValues(alpha: 0.04),
            offset: const Offset(0, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        children: [
          // 头像
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: AvatarImage(
                  avatar: currentChild.avatar,
                  fallbackText: currentChild.name,
                  size: 52,
                ),
              ),
              Positioned(
                bottom: -4,
                right: -8,
                child: StarBadge(
                  count: currentChild.stars,
                  avatarSize: 52,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // 信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        currentChild.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textMain,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (allChildren.length > 1) ...[
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _showChildSwitcher(context, allChildren, currentChild),
                        child: Icon(
                          Icons.swap_horiz_rounded,
                          size: 18,
                          color: AppColors.primary.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _buildInfoTag(
                      icon: currentChild.gender == 'boy' ? Icons.male_rounded : Icons.female_rounded,
                      text: currentChild.gender == 'boy' ? "男孩" : "女孩",
                      color: currentChild.gender == 'boy' ? Colors.blue : Colors.pink,
                    ),
                    if (ageText.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      _buildInfoTag(
                        icon: Icons.cake_rounded,
                        text: ageText,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // 设置按钮
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push<bool>(
                context,
                MaterialPageRoute(builder: (_) => GameSettingsScreen(childId: currentChild.id)),
              );
              if (result == true) {
                ref.invalidate(idiomGradeProgressProvider(currentChild.id));
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.tune_rounded, size: 16, color: AppColors.textSecondary),
                  SizedBox(width: 6),
                  Text(
                    "设置",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 信息标签
  Widget _buildInfoTag({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color.withValues(alpha: 0.8)),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textMain.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  /// 显示宝贝切换弹窗
  void _showChildSwitcher(BuildContext context, List<ChildrenData> children, ChildrenData current) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "选择宝贝",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 16),
            ...children.map((child) => _buildChildSwitcherItem(context, child, child.id == current.id)),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildChildSwitcherItem(BuildContext context, ChildrenData child, bool isSelected) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if (!isSelected) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => GradeSelectionScreen(childId: child.id)),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: AppColors.primary, width: 1.5) : null,
        ),
        child: Row(
          children: [
            AvatarImage(
              avatar: child.avatar,
              fallbackText: child.name,
              size: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                child.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? AppColors.primary : AppColors.textMain,
                ),
              ),
            ),
            StarBadge(count: child.stars, avatarSize: 40),
            if (isSelected) ...[
              const SizedBox(width: 8),
              const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final int grade;
  final String gradeName;
  final bool isUnlocked;
  final bool isCurrent;
  final int stars;
  final VoidCallback? onTap;

  const _LevelCard({
    required this.grade,
    required this.gradeName,
    required this.isUnlocked,
    required this.isCurrent,
    this.stars = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: isCurrent 
          ? Border.all(color: AppColors.primary, width: 2.5)
          : Border.all(color: Colors.transparent, width: 0),
        boxShadow: [
          BoxShadow(
            color: AppColors.textMain.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isUnlocked) ...[
                   Icon(Icons.lock_rounded, size: 24, color: AppColors.textSecondary.withValues(alpha: 0.2)),
                   const SizedBox(height: 8),
                   Text(
                     gradeName, 
                     style: TextStyle(
                       color: AppColors.textSecondary.withValues(alpha: 0.4), 
                       fontWeight: FontWeight.bold,
                       fontSize: 13,
                     ),
                     textAlign: TextAlign.center,
                   ),
                ] else ...[
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: List.generate(3, (index) => Icon(
                       Icons.star_rounded,
                       color: index < stars ? const Color(0xFFFFB020) : AppColors.textSecondary.withValues(alpha: 0.1),
                       size: 14,
                     )),
                   ),
                   const Spacer(),
                   Text(
                     gradeName, 
                     style: const TextStyle(
                       fontSize: 16, 
                       fontWeight: FontWeight.w900, 
                       color: AppColors.textMain,
                       letterSpacing: -0.5,
                     ),
                     textAlign: TextAlign.center,
                   ),
                   const Spacer(),
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                     decoration: BoxDecoration(
                       color: isCurrent ? AppColors.primary : AppColors.background,
                       borderRadius: BorderRadius.circular(12),
                     ),
                     child: Text(
                       isCurrent ? "挑战" : "完成",
                       style: const TextStyle(
                         color: AppColors.textMain,
                         fontWeight: FontWeight.bold,
                         fontSize: 10,
                       ),
                     ),
                   )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}