import 'dart:io';
import 'package:flutter/material.dart';

/// 规则图标工具类
class RuleIcons {
  static const Map<String, IconData> _icons = {
    'star': Icons.star_rounded,
    'menu_book': Icons.menu_book_rounded,
    'book': Icons.menu_book_rounded, // Added for compatibility
    'cleaning_services': Icons.cleaning_services_rounded,
    'sentiment_dissatisfied': Icons.sentiment_dissatisfied_rounded,
    'sentiment_very_dissatisfied': Icons.sentiment_very_dissatisfied_rounded, // Added
    'warning': Icons.warning_rounded,
    'fitness_center': Icons.fitness_center_rounded,
    'piano': Icons.piano_rounded,
    'pets': Icons.pets_rounded,
    'bedtime': Icons.bedtime_rounded,
    'bed': Icons.bed_rounded, // Added
    'restaurant': Icons.restaurant_rounded,
    'brush': Icons.brush_rounded,
    'more_horiz': Icons.more_horiz_rounded,
    'sports_soccer': Icons.sports_soccer_rounded,
    'local_pizza': Icons.local_pizza_rounded,
    'videogame_asset': Icons.videogame_asset_rounded,
    'local_library': Icons.local_library_rounded,
    'computer': Icons.computer_rounded,
    'camera_alt': Icons.camera_alt_rounded,
    'palette': Icons.palette_rounded,
    'music_note': Icons.music_note_rounded,
    'self_improvement': Icons.self_improvement_rounded,
    'directions_walk': Icons.directions_walk_rounded,
    'wash': Icons.wash_rounded,
    'water_drop': Icons.water_drop_rounded, // Added
    'directions_bike': Icons.directions_bike_rounded,
    'emoji_events': Icons.emoji_events_rounded,
    'school': Icons.school_rounded,
    'build': Icons.build_rounded,
    'fastfood': Icons.fastfood_rounded,
    'local_hospital': Icons.local_hospital_rounded,
    'science': Icons.science_rounded,
    'rowing': Icons.rowing_rounded,
    'extension': Icons.extension_rounded,
    'public': Icons.public_rounded,
    'work': Icons.work_rounded,
    'volunteer_activism': Icons.volunteer_activism_rounded,
    'hiking': Icons.hiking_rounded,
    'flight': Icons.flight_rounded,
    'beach_access': Icons.beach_access_rounded,
    'spa': Icons.spa_rounded,
    'sports_mma': Icons.sports_mma_rounded, // Added
    'hearing_disabled': Icons.hearing_disabled_rounded, // Added
    'remove_circle': Icons.remove_circle_rounded, // Added
  };

  /// 根据图标名称获取 IconData
  static IconData getIcon(String? iconName) {
    if (iconName == null || iconName.isEmpty) return Icons.category_rounded;
    return _icons[iconName] ?? Icons.category_rounded;
  }

  /// 判断是否为自定义图片路径
  static bool isImagePath(String? iconNameOrPath) {
    if (iconNameOrPath == null || iconNameOrPath.isEmpty) return false;
    return iconNameOrPath.startsWith('/') || iconNameOrPath.contains(Platform.pathSeparator);
  }

  /// 构建图标或图片 Widget
  static Widget buildIconOrImage(
    String? iconNameOrPath, {
    double size = 24,
    Color? color,
    double borderRadius = 8,
  }) {
    if (iconNameOrPath == null || iconNameOrPath.isEmpty) {
      return Icon(Icons.category_rounded, size: size, color: color);
    }

    // 如果是图片路径
    if (isImagePath(iconNameOrPath)) {
      final file = File(iconNameOrPath);
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.file(file, width: size, height: size, fit: BoxFit.cover),
        );
      }
    }

    // 否则是图标名称
    return Icon(getIcon(iconNameOrPath), size: size, color: color);
  }
}
