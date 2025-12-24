import 'package:flutter/material.dart';
import 'package:children_rewards/shared/widgets/persistent_image.dart';

/// 通用头像显示组件
///
/// 封装了 PersistentImage 并指定为圆形样式
class AvatarImage extends StatelessWidget {
  final String? avatar;
  final String fallbackText;
  final double size;

  const AvatarImage({
    super.key,
    this.avatar,
    required this.fallbackText,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    return PersistentImage(
      imagePath: avatar,
      fallbackText: fallbackText,
      width: size,
      height: size,
      shape: BoxShape.circle,
    );
  }
}
