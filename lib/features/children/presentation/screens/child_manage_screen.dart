import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/core/constants/avatar_data.dart';
import 'package:children_rewards/features/children/data/children_repository.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';
import 'package:children_rewards/features/points/presentation/screens/points_history_screen.dart';
import 'package:children_rewards/features/rule/presentation/screens/rules_manage_screen.dart';
import 'package:children_rewards/features/children/presentation/screens/edit_child_screen.dart';
import 'package:children_rewards/features/exchange/presentation/screens/exchange_history_screen.dart';

class ChildManageScreen extends ConsumerWidget {
  final ChildrenData child;

  const ChildManageScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return const Scaffold();

    final childAsync = ref.watch(childStreamProvider(child.id));

    return childAsync.when(
      data: (latestChild) {
        if (latestChild == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Child not found')),
          );
        }
        return _buildContent(context, ref, latestChild, l10n);
      },
      loading: () => const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, ChildrenData child, AppLocalizations l10n) {
    final topPadding = MediaQuery.of(context).padding.top;
    
    String ageText = "Unknown";
    if (child.birthday != null) {
      try {
        final birthDate = DateTime.parse(child.birthday!);
        final age = DateTime.now().year - birthDate.year;
        ageText = "$age ${l10n.years}";
      } catch (e, stackTrace) {
        logError('解析生日失败', tag: 'ChildManageScreen', error: e, stackTrace: stackTrace);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: 24, 
                right: 24, 
                top: 16 + topPadding,
                bottom: 20
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderButton(icon: Icons.arrow_back_ios_new_rounded, onTap: () => Navigator.pop(context)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.1), spreadRadius: 1)],
                    ),
                    child: Row(
                      children: [
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF88C458), shape: BoxShape.circle)),
                        const SizedBox(width: 8),
                        Text(l10n.manageChild.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1.1)),
                      ],
                    ),
                  ),
                  HeaderButton(
                    icon: Icons.edit_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditChildScreen(child: child),
                        ),
                      );
                    },
                  ), 
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Avatar with Tap to Enlarge
                    GestureDetector(
                      onTap: () => _showEnlargedAvatar(context, child),
                      child: Hero(
                        tag: 'child_avatar_manage_${child.id}',
                        child: Container(
                          width: 140, height: 140,
                          margin: const EdgeInsets.only(top: 10, bottom: 16),
                          decoration: BoxDecoration(
                            color: AppColors.blueTag,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary, width: 4),
                            boxShadow: [
                              BoxShadow(color: AppColors.primary.withOpacity(0.2), offset: const Offset(0, 8), blurRadius: 24, spreadRadius: -2),
                            ],
                          ),
                          child: _buildAvatarContent(child, size: 140),
                        ),
                      ),
                    ),
                    // Star Badge Medal (Bottom Right)
                    Positioned(
                      bottom: 15,
                      right: -5,
                      child: StarBadge(
                        count: child.stars,
                        avatarSize: 140,
                      ),
                    ),
                  ],
                ),
                
                Text(
                  child.name,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textMain),
                ),
                
                const SizedBox(height: 12),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildInfoTag(
                      icon: child.gender == 'boy' ? Icons.male_rounded : Icons.female_rounded,
                      text: child.gender == 'boy' ? l10n.boy : l10n.girl,
                      color: child.gender == 'boy' ? Colors.blue : Colors.pink,
                      bgColor: child.gender == 'boy' ? const Color(0xFFEFF6FF) : const Color(0xFFFFF1F2),
                    ),
                    if (child.birthday != null) ...[
                      const SizedBox(width: 12),
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

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildMenuLink(
                    title: l10n.pointsHistory,
                    subtitle: l10n.pointsHistorySubtitle,
                    icon: Icons.history_rounded,
                    iconBg: const Color(0xFFFFF7ED),
                    iconColor: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PointsHistoryScreen(childId: child.id),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildMenuLink(
                    title: l10n.customRules,
                    subtitle: l10n.customRulesSubtitle,
                    icon: Icons.rule_rounded,
                    iconBg: const Color(0xFFFAF5FF),
                    iconColor: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RulesManageScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildMenuLink(
                    title: l10n.rewardHistory,
                    subtitle: l10n.rewardHistorySubtitle(child.name),
                    icon: Icons.card_giftcard_rounded,
                    iconBg: const Color(0xFFF0FDFA),
                    iconColor: Colors.teal,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExchangeHistoryScreen(childId: child.id),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          _showDeleteConfirm(context, ref, l10n, child.id, child.name),
                      icon: const Icon(Icons.delete_outline_rounded, size: 20),
                      label: Text(
                        l10n.deleteChildProfile,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEF2F2),
                        foregroundColor: const Color(0xFFEF4444),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Color(0xFFFEE2E2), width: 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40), // Bottom breathing space
                ],
              ),
            ),
          ),
        ],
      ),
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
        Navigator.pop(context); // Close management screen
      }
    }
  }

  void _showEnlargedAvatar(BuildContext context, ChildrenData child) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9), // Deep dark background
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
    if (child.avatar != null) {
      if (child.avatar!.startsWith('builtin:')) {
        final index = int.tryParse(child.avatar!.split(':')[1]) ?? 0;
        if (index >= 0 && index < AvatarData.builtInSvgs.length) {
          return ClipOval(
            child: SvgPicture.string(
              AvatarData.builtInSvgs[index],
              fit: BoxFit.cover,
              width: size, height: size,
            ),
          );
        }
      } else {
        final file = File(child.avatar!);
        if (file.existsSync()) {
          return ClipOval(
            child: Image.file(
              file,
              fit: BoxFit.cover,
              width: size, height: size,
            ),
          );
        }
      }
    }
    return Center(
      child: Text(
        child.name.isNotEmpty ? child.name[0].toUpperCase() : "?",
        style: TextStyle(fontSize: size * 0.4, fontWeight: FontWeight.bold, color: AppColors.textMain),
      ),
    );
  }

  Widget _buildInfoTag({required IconData icon, required String text, required Color color, required Color bgColor}) {
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
              color: color.withOpacity(0.8),
              letterSpacing: 0.5,
            )
          ),
        ],
      ),
    );
  }

  Widget _buildMenuLink({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.textMain.withOpacity(0.04), // Softer shadow matching ChildCard
              offset: const Offset(0, 4), 
              blurRadius: 16,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(20)),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary.withOpacity(0.5), size: 20),
          ],
        ),
      ),
    );
  }
}
