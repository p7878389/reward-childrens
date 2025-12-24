import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

/// 星星勋章组件
/// 
/// 常用于悬挂在头像右上角，展示积分或成就
class StarBadge extends StatelessWidget {
  final int count;
  final double? avatarSize;

  const StarBadge({
    super.key,
    required this.count,
    this.avatarSize,
  });

  @override
  Widget build(BuildContext context) {
    // 根据头像大小缩放比例
    final double scale = avatarSize != null ? (avatarSize! / 72.0).clamp(0.8, 1.5) : 1.0;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 4 * scale),
      decoration: BoxDecoration(
        color: AppColors.primary, // 回归品牌黄
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: Colors.white, width: 2.5 * scale), // 明显的白色描边
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            offset: Offset(0, 4 * scale),
            blurRadius: 10 * scale,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded, 
            color: Colors.white, 
            size: 14 * scale,
          ),
          SizedBox(width: 2 * scale),
          Text(
            count.toString(),
            style: TextStyle(
              color: Colors.white, // 纯白文字
              fontSize: 12 * scale,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
