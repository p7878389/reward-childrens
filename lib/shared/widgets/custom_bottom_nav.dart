import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

class CustomBottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    this.selectedIndex = 0,
    required this.onTap,
  });

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  bool _enableBlur = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        setState(() {
          _enableBlur = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 获取底部安全距离
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final widget = RepaintBoundary(
      child: ClipRRect(
        child: BackdropFilter(
          filter: _enableBlur ? ImageFilter.blur(sigmaX: 16, sigmaY: 16) : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Container(
            // 总高度 = 交互区高度 + 底部安全区高度
            height: 64 + bottomPadding,
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.9),
              border: Border(
                top: BorderSide(color: AppColors.textMain.withValues(alpha: 0.05)),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textMain.withValues(alpha: 0.02),
                  offset: const Offset(0, -4),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_rounded),
                  _buildNavItem(1, Icons.store_rounded), // Store moved to index 1
                  _buildNavItem(2, Icons.settings_rounded), // Settings moved to index 2
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return widget;
  }

  Widget _buildNavItem(int index, IconData icon) {
    final bool isSelected = widget.selectedIndex == index;
    
    return Expanded(
      child: InkWell(
        onTap: () => widget.onTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          // 撑满 Expanded 提供的所有空间，最大化点击范围
          height: double.infinity,
          alignment: Alignment.center,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: isSelected ? 1.15 : 1.0, // 选中时微弱放大，替代圆圈
            child: Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.4),
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
