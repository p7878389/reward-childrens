import 'dart:io';
import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/badges/domain/usecases/get_child_badges_usecase.dart';

class BadgeCard extends StatelessWidget {
  final ChildBadgeDisplay badgeDisplay;
  final VoidCallback onTap;

  const BadgeCard({
    super.key,
    required this.badgeDisplay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isAcquired = badgeDisplay.isAcquired;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isAcquired ? Colors.white : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(24),
          border: isAcquired
              ? Border.all(color: AppColors.primary.withOpacity(0.1), width: 1)
              : null,
          boxShadow: isAcquired
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  )
                ]
              : [],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Expanded(
              flex: 3,
              child: Opacity(
                opacity: isAcquired ? 1.0 : 0.5,
                child: _buildIcon(context),
              ),
            ),
            const SizedBox(height: 8),
            // Name
            Text(
              badgeDisplay.badge.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isAcquired ? AppColors.textMain : AppColors.textSecondary,
              ),
            ),
            if (!isAcquired) ...[
              const SizedBox(height: 6),
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: badgeDisplay.progress,
                  backgroundColor: Colors.black12,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 4,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final iconPath = badgeDisplay.badge.icon;
    
    if (iconPath.startsWith('/') || iconPath.contains('cache') || iconPath.contains('app_flutter')) {
      final file = File(iconPath);
      if (file.existsSync()) {
        return ClipOval(
          child: Image.file(
            file,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            color: badgeDisplay.isAcquired ? null : Colors.grey,
            colorBlendMode: badgeDisplay.isAcquired ? null : BlendMode.saturation,
          ),
        );
      }
    }

    // Map icon string to Flutter IconData or Asset
    // Using simple mapping for now based on icon string
    IconData iconData = Icons.stars_rounded;
    Color iconColor = AppColors.primary;

    if (badgeDisplay.badge.icon.contains('calendar')) {
      iconData = Icons.calendar_month_rounded;
      iconColor = Colors.blueAccent;
    } else if (badgeDisplay.badge.icon.contains('gift')) {
      iconData = Icons.card_giftcard_rounded;
      iconColor = Colors.purpleAccent;
    } else if (badgeDisplay.badge.icon.contains('lightning')) {
      iconData = Icons.bolt_rounded;
      iconColor = Colors.orangeAccent;
    } else if (badgeDisplay.badge.icon.contains('silver')) {
      iconColor = Colors.grey;
    } else if (badgeDisplay.badge.icon.contains('bronze')) {
      iconColor = Colors.brown;
    }

    if (!badgeDisplay.isAcquired) {
      iconColor = Colors.grey;
    }

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: badgeDisplay.isAcquired ? iconColor.withOpacity(0.1) : Colors.black12,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 32,
      ),
    );
  }
}
