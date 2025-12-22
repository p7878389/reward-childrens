import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

class FilterTabData {
  final String label;
  final String value;

  const FilterTabData({required this.label, required this.value});
}

class CommonFilterTabs extends StatelessWidget {
  final List<FilterTabData> tabs;
  final String selectedValue;
  final ValueChanged<String> onSelect;

  const CommonFilterTabs({
    super.key,
    required this.tabs,
    required this.selectedValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF2EFE5).withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: tabs.map((tab) => _buildFilterBtn(tab)).toList(),
      ),
    );
  }

  Widget _buildFilterBtn(FilterTabData tab) {
    final isSelected = selectedValue == tab.value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelect(tab.value),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.background : null,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, 2), blurRadius: 8)] : null,
          ),
          alignment: Alignment.center,
          child: Text(
            tab.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.textMain : AppColors.textSecondary.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
