import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

/// 日期选择输入框组件
///
/// 点击后弹出日期选择器
class DatePickerField extends StatelessWidget {
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final String hintText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String dateFormat;

  const DatePickerField({
    super.key,
    this.value,
    required this.onChanged,
    required this.hintText,
    this.firstDate,
    this.lastDate,
    this.dateFormat = 'yyyy-MM-dd',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(1990),
          lastDate: lastDate ?? DateTime.now(),
        );
        if (date != null) {
          onChanged(date);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            const Icon(Icons.cake_rounded, color: AppColors.textSecondary, size: 20),
            const SizedBox(width: 12),
            Text(
              value == null ? hintText : DateFormat(dateFormat).format(value!),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: value == null ? AppColors.textSecondary.withOpacity(0.5) : AppColors.textMain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
