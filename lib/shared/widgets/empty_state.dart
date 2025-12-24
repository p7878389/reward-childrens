import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

/// 空状态组件 - 优化为更极致的简约风格
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String? message; // 变为可选
  final String? description;
  final String? actionText;
  final VoidCallback? onAction;
  final double iconSize;

  const EmptyState({
    super.key,
    required this.icon,
    this.message,
    this.description,
    this.actionText,
    this.onAction,
    this.iconSize = 100, // 进一步加大图标
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center vertically for better balance in lists
        children: [
          // Exquisite Icon with Background Decoration
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: iconSize * 1.6,
                height: iconSize * 1.6,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.04),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: iconSize * 1.2,
                height: iconSize * 1.2,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: iconSize * 0.6,
                  color: AppColors.primary.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          
          if (message != null) ...[
            const SizedBox(height: 24),
            Text(
              message!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.textMain,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          
          if (description != null) ...[
            const SizedBox(height: 12),
            Text(
              description!,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary.withValues(alpha: 0.6),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          
          if (actionText != null && onAction != null) ...[
            const SizedBox(height: 40),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add_rounded, size: 22),
                label: Text(
                  actionText!,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: AppColors.primary.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Sliver 版本的空状态组件
class SliverEmptyState extends StatelessWidget {
  final IconData icon;
  final String? message;
  final String? description;
  final String? actionText;
  final VoidCallback? onAction;
  final double iconSize;

  const SliverEmptyState({
    super.key,
    required this.icon,
    this.message,
    this.description,
    this.actionText,
    this.onAction,
    this.iconSize = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: EmptyState(
        icon: icon,
        message: message,
        description: description,
        actionText: actionText,
        onAction: onAction,
        iconSize: iconSize,
      ),
    );
  }
}
