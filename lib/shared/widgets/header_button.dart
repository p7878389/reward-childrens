import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

/// 通用圆形头部按钮组件
///
/// 用于页面顶部的返回、编辑等操作按钮
class HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;

  const HeaderButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 40,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: AppColors.primary.withOpacity(0.1), spreadRadius: 1),
            BoxShadow(color: AppColors.textMain.withOpacity(0.03), offset: const Offset(0, 4), blurRadius: 14),
          ],
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: iconSize),
      ),
    );
  }
}
