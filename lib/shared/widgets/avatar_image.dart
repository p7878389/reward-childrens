import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/constants/avatar_data.dart';

/// 通用头像显示组件
///
/// 支持三种头像类型：
/// - 内置 SVG 头像 (格式: "builtin:index")
/// - 本地文件路径
/// - 默认首字母头像
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
    if (avatar != null) {
      // 内置 SVG 头像
      if (avatar!.startsWith('builtin:')) {
        final index = int.tryParse(avatar!.split(':')[1]) ?? 0;
        if (index >= 0 && index < AvatarData.builtInSvgs.length) {
          return ClipOval(
            child: SvgPicture.string(
              AvatarData.builtInSvgs[index],
              fit: BoxFit.cover,
              width: size,
              height: size,
            ),
          );
        }
      } else {
        // 本地文件头像
        final file = File(avatar!);
        if (file.existsSync()) {
          return ClipOval(
            child: Image.file(
              file,
              fit: BoxFit.cover,
              width: size,
              height: size,
            ),
          );
        }
      }
    }

    // 默认首字母头像
    return Center(
      child: Text(
        fallbackText.isNotEmpty ? fallbackText[0].toUpperCase() : "?",
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: AppColors.textMain,
        ),
      ),
    );
  }
}
