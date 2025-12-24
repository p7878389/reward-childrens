import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/badges/providers/badge_providers.dart';
import 'package:children_rewards/features/badges/presentation/widgets/badge_card.dart';
import 'package:children_rewards/features/badges/presentation/dialogs/badge_detail_dialog.dart';

import 'package:children_rewards/shared/widgets/common_widgets.dart';

class BadgeGalleryScreen extends ConsumerWidget {
  final int childId;
  final String childName;

  const BadgeGalleryScreen({
    super.key,
    required this.childId,
    required this.childName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badgesAsync = ref.watch(childBadgesProvider(childId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: '$childName 的徽章'),
            Expanded(
              child: badgesAsync.when(
                data: (badges) {
                  if (badges.isEmpty) {
                    return const Center(child: Text('暂无徽章', style: TextStyle(color: AppColors.textSecondary)));
                  }

                  final acquiredCount = badges.where((b) => b.isAcquired).length;
                  final totalCount = badges.length;

                  return Column(
                    children: [
                      // Summary Header
                      Container(
                        margin: const EdgeInsets.all(24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 32),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '徽章收集进度',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$acquiredCount / $totalCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Badge Grid
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: badges.length,
                          itemBuilder: (context, index) {
                            final badge = badges[index];
                            return BadgeCard(
                              badgeDisplay: badge,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => BadgeDetailDialog(badgeDisplay: badge),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
