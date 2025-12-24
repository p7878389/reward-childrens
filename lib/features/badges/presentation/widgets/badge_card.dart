import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/badges/domain/usecases/get_child_badges_usecase.dart';
import 'package:children_rewards/features/badges/presentation/widgets/badge_icon.dart';

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
              ? Border.all(color: AppColors.primary.withValues(alpha: 0.1), width: 1)
              : null,
          boxShadow: isAcquired
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
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
              child: BadgeIcon(
                icon: badgeDisplay.badge.icon,
                isAcquired: isAcquired,
                size: 56,
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
}

