import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/shared/widgets/swipeable_card.dart';
import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/providers/badge_providers.dart';
import 'package:children_rewards/features/badges/presentation/screens/add_badge_screen.dart';
import 'package:children_rewards/features/badges/presentation/screens/edit_badge_screen.dart';

class BadgeManageScreen extends ConsumerWidget {
  const BadgeManageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badgesAsync = ref.watch(allBadgesStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('徽章管理',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMain)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textMain),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded, color: AppColors.textMain, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddBadgeScreen()),
              ).then((_) => ref.invalidate(allBadgesStreamProvider));
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: badgesAsync.when(
        data: (badges) {
          if (badges.isEmpty) {
            return const Center(child: Text('暂无徽章配置'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: badges.length,
            itemBuilder: (context, index) {
              final badge = badges[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildBadgeItem(context, ref, badge),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildBadgeItem(BuildContext context, WidgetRef ref, BadgeEntity badge) {
    return Slidable(
      key: ValueKey(badge.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            label: '删除',
            icon: Icons.delete_outline_rounded,
            backgroundColor: const Color(0xFFFEF2F2),
            foregroundColor: const Color(0xFFEF4444),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            onPressed: (context) => _showDeleteConfirm(context, ref, badge),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditBadgeScreen(badge: badge)),
          ).then((_) => ref.invalidate(allBadgesStreamProvider));
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: badge.isActive ? Colors.white : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Opacity(
                opacity: badge.isActive ? 1.0 : 0.4,
                child: _buildBadgeIcon(badge.icon),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          badge.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: badge.isActive ? AppColors.textMain : AppColors.textSecondary,
                            decoration: badge.isActive ? null : TextDecoration.lineThrough,
                          ),
                        ),
                        if (badge.isSystem)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('系统',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      badge.triggerDescription,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary.withOpacity(0.3)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeIcon(String iconPath) {
    if (iconPath.startsWith('/') || iconPath.contains('cache') || iconPath.contains('app_flutter')) {
      final file = File(iconPath);
      if (file.existsSync()) {
        return ClipOval(
          child: Image.file(file, width: 48, height: 48, fit: BoxFit.cover),
        );
      }
    }

    IconData iconData = Icons.stars_rounded;
    Color color = AppColors.primary;

    if (iconPath.contains('calendar')) {
      iconData = Icons.calendar_month_rounded;
      color = Colors.blueAccent;
    } else if (iconPath.contains('gift')) {
      iconData = Icons.card_giftcard_rounded;
      color = Colors.purpleAccent;
    } else if (iconPath.contains('lightning')) {
      iconData = Icons.bolt_rounded;
      color = Colors.orangeAccent;
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: color, size: 28),
    );
  }

  

  void _showDeleteConfirm(BuildContext context, WidgetRef ref, BadgeEntity badge) async {
    await SwipeDeleteHelper.showDeleteConfirmDialog(
      context: context,
      title: '删除徽章',
      message: '确定要删除徽章"${badge.name}"吗？这将无法撤销。',
      onConfirm: () async {
        await ref.read(badgeRepositoryProvider).delete(badge.id);
        ref.invalidate(allBadgesStreamProvider);
      },
    );
  }
}