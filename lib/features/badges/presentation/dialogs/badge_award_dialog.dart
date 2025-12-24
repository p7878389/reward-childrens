import 'dart:io';
import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';

class BadgeAwardDialog extends StatelessWidget {
  final BadgeEntity badge;
  final VoidCallback onDismiss;

  const BadgeAwardDialog({
    super.key,
    required this.badge,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Card
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 32, left: 24, right: 24),
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 30,
                  offset: Offset(0, 20),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '恭喜获得新徽章!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  badge.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badge.triggerDescription,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                if (badge.bonusPoints > 0)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, color: AppColors.primary, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          '+${badge.bonusPoints} 星星奖励',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: onDismiss,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 8,
                      shadowColor: AppColors.primary.withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    ),
                    child: const Text(
                      '太棒了!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Floating Icon on Top
          Positioned(
            top: 0,
            child: _buildHeaderIcon(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon() {
    final iconPath = badge.icon;

    if (iconPath.startsWith('/') || iconPath.contains('cache') || iconPath.contains('app_flutter')) {
      final file = File(iconPath);
      if (file.existsSync()) {
        return Container(
          width: 96,
          height: 96,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(4),
          child: ClipOval(
            child: Image.file(file, width: 96, height: 96, fit: BoxFit.cover),
          ),
        );
      }
    }

    IconData iconData = Icons.stars_rounded;
    Color iconColor = AppColors.primary;

    if (badge.icon.contains('calendar')) {
      iconData = Icons.calendar_month_rounded;
      iconColor = Colors.blueAccent;
    } else if (badge.icon.contains('gift')) {
      iconData = Icons.card_giftcard_rounded;
      iconColor = Colors.purpleAccent;
    } else if (badge.icon.contains('lightning')) {
      iconData = Icons.bolt_rounded;
      iconColor = Colors.orangeAccent;
    } else if (badge.icon.contains('silver')) {
      iconColor = Colors.grey;
    } else if (badge.icon.contains('bronze')) {
      iconColor = Colors.brown;
    }

    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: iconColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: iconColor,
          size: 56,
        ),
      ),
    );
  }
}
