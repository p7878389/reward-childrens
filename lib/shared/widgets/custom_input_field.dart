import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withValues(alpha: 0.08)), // More visible border
        ),
        child: SizedBox(
          height: maxLines > 1 ? null : 56, // Fixed height for single line
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            onChanged: onChanged,
            enabled: enabled,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(icon, color: AppColors.textSecondary, size: 20),
              hintText: hintText,
              hintStyle: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.3)),
              contentPadding: maxLines > 1 ? const EdgeInsets.symmetric(vertical: 12) : null,
            ),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
