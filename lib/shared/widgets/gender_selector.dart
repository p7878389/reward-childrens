import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

/// 性别选择器组件
///
/// 提供男孩/女孩两个选项的选择器
class GenderSelector extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final String boyLabel;
  final String girlLabel;

  const GenderSelector({
    super.key,
    required this.value,
    required this.onChanged,
    required this.boyLabel,
    required this.girlLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildGenderCard('boy', Icons.male, Colors.blue, boyLabel)),
        const SizedBox(width: 12),
        Expanded(child: _buildGenderCard('girl', Icons.female, Colors.pink, girlLabel)),
      ],
    );
  }

  Widget _buildGenderCard(String genderValue, IconData icon, Color color, String label) {
    final isSelected = value == genderValue;
    return GestureDetector(
      onTap: () => onChanged(genderValue),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? color : Colors.black.withValues(alpha: 0.05)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? color : AppColors.textSecondary.withValues(alpha: 0.5), size: 20),
            const SizedBox(width: 8),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? color : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
