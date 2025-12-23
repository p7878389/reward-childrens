import 'dart:io';
import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/badges/domain/usecases/get_child_badges_usecase.dart';
import 'package:intl/intl.dart';

class BadgeDetailDialog extends StatelessWidget {
  final ChildBadgeDisplay badgeDisplay;

  const BadgeDetailDialog({super.key, required this.badgeDisplay});

  @override
  Widget build(BuildContext context) {
    final isAcquired = badgeDisplay.isAcquired;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      backgroundColor: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Header
            _buildHeaderIcon(context),
            const SizedBox(height: 24),

            // Title
            Text(
              badgeDisplay.badge.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 8),

            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isAcquired ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isAcquired ? '已获得' : '进行中',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isAcquired ? const Color(0xFF2E7D32) : const Color(0xFFEF6C00),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Description
            Text(
              badgeDisplay.badge.description ?? badgeDisplay.badge.triggerDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Info Grid
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildInfoRow(
                    context,
                    label: '获得条件',
                    value: badgeDisplay.badge.triggerDescription,
                    icon: Icons.rule_rounded,
                  ),
                  if (badgeDisplay.badge.bonusPoints > 0) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, color: Colors.black12),
                    ),
                    _buildInfoRow(
                      context,
                      label: '奖励',
                      value: '+${badgeDisplay.badge.bonusPoints} 星星',
                      icon: Icons.star_rounded,
                      valueColor: AppColors.primary,
                    ),
                  ],
                  if (isAcquired && badgeDisplay.acquisition != null) ...[
                     const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, color: Colors.black12),
                    ),
                    _buildInfoRow(
                      context,
                      label: '获得时间',
                      value: DateFormat('yyyy-MM-dd').format(badgeDisplay.acquisition!.createdAt),
                      icon: Icons.event_available_rounded,
                    ),
                  ] else ...[
                     const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, color: Colors.black12),
                    ),
                    _buildInfoRow(
                      context,
                      label: '当前进度',
                      value: '${badgeDisplay.currentValue} / ${badgeDisplay.badge.triggerThreshold}',
                      icon: Icons.trending_up_rounded,
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: badgeDisplay.progress,
                        backgroundColor: Colors.black12,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                  foregroundColor: AppColors.textMain,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                ),
                child: const Text(
                  '关闭',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary.withOpacity(0.5)),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary.withOpacity(0.8),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppColors.textMain,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderIcon(BuildContext context) {
    final iconPath = badgeDisplay.badge.icon;

    if (iconPath.startsWith('/') || iconPath.contains('cache') || iconPath.contains('app_flutter')) {
      final file = File(iconPath);
      if (file.existsSync()) {
        return Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: badgeDisplay.isAcquired
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ]
                : [],
          ),
          child: ClipOval(
            child: Image.file(
              file,
              width: 88,
              height: 88,
              fit: BoxFit.cover,
              color: badgeDisplay.isAcquired ? null : Colors.grey,
              colorBlendMode: badgeDisplay.isAcquired ? null : BlendMode.saturation,
            ),
          ),
        );
      }
    }

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
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
        boxShadow: badgeDisplay.isAcquired
            ? [
                BoxShadow(
                  color: iconColor.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ]
            : [],
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 48,
      ),
    );
  }
}
