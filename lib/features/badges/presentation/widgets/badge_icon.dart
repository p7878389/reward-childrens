import 'dart:io';
import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/services/file_storage_service.dart';

class BadgeIcon extends StatelessWidget {
  final String icon;
  final double size;
  final bool isAcquired;
  final bool isActive;

  const BadgeIcon({
    super.key,
    required this.icon,
    this.size = 48,
    this.isAcquired = true,
    this.isActive = true,
  });

  static const List<Map<String, dynamic>> systemIcons = [
    {'value': 'star', 'icon': Icons.stars_rounded, 'color': AppColors.primary, 'label': '星星'},
    {'value': 'calendar', 'icon': Icons.calendar_month_rounded, 'color': Colors.blueAccent, 'label': '日历'},
    {'value': 'gift', 'icon': Icons.card_giftcard_rounded, 'color': Colors.purpleAccent, 'label': '礼物'},
    {'value': 'lightning', 'icon': Icons.bolt_rounded, 'color': Colors.orangeAccent, 'label': '闪电'},
    {'value': 'silver', 'icon': Icons.stars_rounded, 'color': Colors.grey, 'label': '银牌'},
    {'value': 'bronze', 'icon': Icons.stars_rounded, 'color': Colors.brown, 'label': '铜牌'},
  ];

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (isAcquired && isActive) ? 1.0 : 0.4,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    // 1. Check if it's a file path
    if (icon.contains('/') || icon.contains(Platform.pathSeparator)) {
      String absolutePath = icon.startsWith('/') ? icon : FileStorageService.getAbsolutePath(icon);
      final file = File(absolutePath);
      if (file.existsSync()) {
        return ClipOval(
          child: Image.file(
            file,
            width: size,
            height: size,
            fit: BoxFit.cover,
            color: isAcquired ? null : Colors.grey,
            colorBlendMode: isAcquired ? null : BlendMode.saturation,
            errorBuilder: (_, __, ___) => _buildSystemIcon('star'),
          ),
        );
      }
    }

    // 2. Handle system icons
    return _buildSystemIcon(icon);
  }

  Widget _buildSystemIcon(String iconValue) {
    final systemIcon = systemIcons.firstWhere(
      (element) => element['value'] == iconValue || (iconValue.contains(element['value'] as String) && element['value'] != 'star'),
      orElse: () => systemIcons[0], // Default to star
    );

    Color iconColor = systemIcon['color'] as Color;
    if (!isAcquired) {
      iconColor = Colors.grey;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isAcquired ? iconColor.withValues(alpha: 0.1) : Colors.black12,
        shape: BoxShape.circle,
      ),
      child: Icon(
        systemIcon['icon'] as IconData,
        color: iconColor,
        size: size * 0.6,
      ),
    );
  }
}
