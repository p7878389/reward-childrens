import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/theme/app_dimens.dart';
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/features/children/data/children_repository.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';
import 'package:children_rewards/features/points/presentation/screens/points_history_screen.dart';
import 'package:children_rewards/features/children/presentation/screens/edit_child_screen.dart';
import 'package:children_rewards/features/exchange/presentation/screens/exchange_history_screen.dart';
import 'package:children_rewards/features/badges/providers/badge_providers.dart';
import 'package:children_rewards/features/badges/presentation/screens/badge_gallery_screen.dart';
import 'package:children_rewards/features/badges/presentation/dialogs/checkin_success_dialog.dart';
import 'package:children_rewards/features/badges/presentation/dialogs/badge_award_dialog.dart';
import 'package:children_rewards/features/badges/domain/usecases/checkin_usecase.dart';
import 'package:children_rewards/features/idiom_game/presentation/screens/game_hall_screen.dart';

class ChildManageScreen extends ConsumerWidget {
  final ChildrenData child;

  const ChildManageScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return const Scaffold();

    final childAsync = ref.watch(childStreamProvider(child.id));
    final badgesAsync = ref.watch(childAcquiredBadgesProvider(child.id));
    final hasCheckedInAsync = ref.watch(hasCheckedInTodayProvider(child.id));

    return childAsync.when(
      data: (latestChild) {
        if (latestChild == null) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Column(
                children: [
                  AppHeader(title: l10n.manageChild),
                  const Expanded(child: Center(child: Text('Child not found'))),
                ],
              ),
            ),
          );
        }
        final badgeCount = badgesAsync.valueOrNull?.length ?? 0;
        final hasCheckedIn = hasCheckedInAsync.valueOrNull ?? false;
        
        return _buildContent(context, ref, latestChild, badgeCount, hasCheckedIn, l10n);
      },
      loading: () => const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => ErrorScreen(
        title: l10n.errorTitle,
        message: err.toString(),
        stackTrace: stack.toString(),
        onRetry: () {
          // ignore: unused_result
          ref.refresh(childStreamProvider(child.id));
          // ignore: unused_result
          ref.refresh(hasCheckedInTodayProvider(child.id));
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, 
    WidgetRef ref, 
    ChildrenData child, 
    int badgeCount,
    bool hasCheckedIn,
    AppLocalizations l10n
  ) {
    String ageText = "??";
    if (child.birthday != null) {
      try {
        final birthDate = DateTime.parse(child.birthday!);
        final age = DateTime.now().year - birthDate.year;
        ageText = "$age";
      } catch (e, stackTrace) {
        logError('解析生日失败', tag: 'ChildManageScreen', error: e, stackTrace: stackTrace);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: AppHeader(
              title: l10n.manageChild,
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingL),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: AppDimens.paddingS),
                
                // 1. Compact Profile Card (Horizontal)
                _buildProfileCard(context, child, badgeCount, l10n, ageText),
                
                const SizedBox(height: AppDimens.paddingL),

                // 2. Game Entry Card (Featured)
                _buildGameCard(context, l10n, child),

                const SizedBox(height: AppDimens.paddingL),
                
                // 3. Action Grid (Dashboard Style)
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildDashboardTile(
                                title: hasCheckedIn ? l10n.alreadyCheckedin : l10n.dailyCheckin,
                                icon: Icons.calendar_today_rounded,
                                color: hasCheckedIn ? Colors.grey : Colors.teal,
                                onTap: hasCheckedIn ? null : () => _handleCheckin(context, ref, l10n, child.id),
                                isGrey: hasCheckedIn,
                              ),
                            ),
                            const SizedBox(width: AppDimens.paddingM),
                            Expanded(
                              child: _buildDashboardTile(
                                title: l10n.pointsHistory,
                                icon: Icons.history_rounded,
                                color: Colors.orange,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PointsHistoryScreen(childId: child.id),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppDimens.paddingM),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDashboardTile(
                                title: l10n.growthBadges,
                                icon: Icons.emoji_events_rounded,
                                color: Colors.deepPurple,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BadgeGalleryScreen(
                                        childId: child.id,
                                        childName: child.name,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: AppDimens.paddingM),
                            Expanded(
                              child: _buildDashboardTile(
                                title: l10n.rewardHistory,
                                icon: Icons.card_giftcard_rounded,
                                color: const Color(0xFFF43F5E),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ExchangeHistoryScreen(childId: child.id),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: AppDimens.paddingXXL),

                // 4. Discreet Delete Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () => _showDeleteConfirm(context, ref, l10n, child.id, child.name),
                    icon: const Icon(Icons.delete_outline_rounded, size: 20),
                    label: Text(l10n.deleteChildProfile),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimens.radiusM),
                      ),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w900, 
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: AppDimens.paddingXXL),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, AppLocalizations l10n, ChildrenData child) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameHallScreen(childId: child.id),
          ),
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF818CF8)], // Indigo gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppDimens.radiusL),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withValues(alpha: 0.3),
              offset: const Offset(0, 8),
              blurRadius: 20,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Pattern
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Icons.sports_esports_rounded,
                size: 140,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "游戏大厅", // "Game Center"
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "成语接龙、填字挑战、看意猜词...",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context,
    ChildrenData child,
    int badgeCount,
    AppLocalizations l10n,
    String ageText
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditChildScreen(child: child),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
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
          // Avatar
          GestureDetector(
            onTap: () => _showEnlargedAvatar(context, child),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Hero(
                  tag: 'child_avatar_manage_${child.id}',
                  child: Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: AppColors.blueTag,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textMain.withValues(alpha: 0.1),
                          offset: const Offset(0, 4),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: _buildAvatarContent(child, size: 88),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: -4,
                  child: StarBadge(
                    count: child.stars,
                    avatarSize: 88,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: AppDimens.paddingL),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  child.name,
                  style: const TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.w900, 
                    color: AppColors.textMain,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildCompactStat(
                      icon: child.gender == 'boy' ? Icons.male_rounded : Icons.female_rounded,
                      text: child.gender == 'boy' ? l10n.boy : l10n.girl,
                      color: child.gender == 'boy' ? Colors.blue : Colors.pink,
                    ),
                    const SizedBox(width: 12),
                    _buildCompactStat(
                      icon: Icons.cake_rounded,
                      text: "$ageText ${l10n.years}",
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                _buildCompactStat(
                  icon: Icons.emoji_events_rounded,
                  text: "$badgeCount ${l10n.growthBadges}",
                  color: Colors.deepPurple,
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildCompactStat({
    required IconData icon, 
    required String text, 
    required Color color
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

  Widget _buildDashboardTile({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback? onTap,
    bool isGrey = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isGrey ? 0.6 : 1.0,
        child: Container(
          height: 120, // Clean square-ish ratio
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimens.radiusL),
            boxShadow: [
              BoxShadow(
                color: AppColors.textMain.withValues(alpha: 0.04),
                offset: const Offset(0, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.w700, 
                  color: isGrey ? AppColors.textSecondary : AppColors.textMain,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleCheckin(BuildContext context, WidgetRef ref, AppLocalizations l10n, int childId) async {
    final result = await ref.read(checkinUseCaseProvider).execute(CheckinParams(
      childId: childId,
      rewardPoints: 1,
    ));

    result.when(
      success: (checkinResult) {
        // Refresh checkin status
        // ignore: unused_result
        ref.refresh(hasCheckedInTodayProvider(childId));
        
        showDialog(
          context: context,
          builder: (context) => CheckinSuccessDialog(
            streakDays: checkinResult.streakDays,
            rewardPoints: 1,
          ),
        ).then((_) {
          if (!context.mounted) return;
          if (checkinResult.badgeResult != null && checkinResult.badgeResult!.hasBadges) {
            for (final badge in checkinResult.badgeResult!.awardedBadges) {
               showDialog(
                context: context,
                builder: (context) => BadgeAwardDialog(
                  badge: badge,
                  onDismiss: () => Navigator.pop(context),
                ),
              );
            }
          }
        });
      },
      failure: (message, _, __) async {
        if (message == '今日已签到' || message == l10n.alreadyCheckedin) {
          // If we somehow clicked it but it failed due to already checked in, refresh status
          // ignore: unused_result
          ref.refresh(hasCheckedInTodayProvider(childId));
          
          final streakDays = await ref.read(checkinRepositoryProvider).getCurrentStreak(childId);
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) => CheckinSuccessDialog(
                streakDays: streakDays,
                rewardPoints: 0,
                isAlreadyCheckedin: true,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.orange,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      },
    );
  }

  void _showDeleteConfirm(BuildContext context, WidgetRef ref, AppLocalizations l10n, int childId, String name) async {
    final confirmed = await AppDialogs.showDeleteConfirm(
      context: context,
      title: l10n.deleteChildTitle(name),
      message: l10n.deleteUndone,
      confirmText: l10n.yesDelete,
    );

    if (confirmed) {
      await ref.read(childrenRepositoryProvider).deleteChild(childId);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _showEnlargedAvatar(BuildContext context, ChildrenData child) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (context) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Hero(
            tag: 'child_avatar_manage_${child.id}',
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.width * 0.85,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(4),
                child: _buildAvatarContent(child, size: 400),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarContent(ChildrenData child, {double size = 100}) {
    return AvatarImage(
      avatar: child.avatar,
      fallbackText: child.name,
      size: size,
    );
  }
}