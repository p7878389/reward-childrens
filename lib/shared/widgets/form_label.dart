import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

/// 通用表单标签组件
///
/// 用于表单字段上方的标签文本
class FormLabel extends StatelessWidget {
  final String text;
  final bool uppercase;

  const FormLabel({
    super.key,
    required this.text,
    this.uppercase = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      uppercase ? text.toUpperCase() : text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
      ),
    );
  }
}
