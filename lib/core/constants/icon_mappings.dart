import 'package:flutter/material.dart';

/// 规则图标映射 - 统一管理所有可用图标
class RuleIconMappings {
  RuleIconMappings._();

  /// 可用图标名称列表
  static const List<String> availableIcons = [
    'star',
    'menu_book',
    'cleaning_services',
    'fitness_center',
    'piano',
    'pets',
    'bedtime',
    'restaurant',
    'brush',
    'more_horiz',
    'sports_soccer',
    'local_pizza',
    'videogame_asset',
    'local_library',
    'computer',
    'camera_alt',
    'palette',
    'music_note',
    'self_improvement',
    'directions_walk',
    'wash',
    'directions_bike',
    'emoji_events',
    'school',
    'build',
    'fastfood',
    'local_hospital',
    'science',
    'rowing',
    'extension',
    'public',
    'work',
    'volunteer_activism',
    'hiking',
    'flight',
    'beach_access',
    'spa',
  ];

  /// 图标名称到 IconData 的映射
  static const Map<String, IconData> _iconMap = {
    'menu_book': Icons.menu_book_rounded,
    'cleaning_services': Icons.cleaning_services_rounded,
    'sentiment_dissatisfied': Icons.sentiment_dissatisfied_rounded,
    'warning': Icons.warning_rounded,
    'star': Icons.star_rounded,
    'fitness_center': Icons.fitness_center_rounded,
    'piano': Icons.piano_rounded,
    'pets': Icons.pets_rounded,
    'bedtime': Icons.bedtime_rounded,
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
  };

  /// 根据图标名称获取 IconData
  static IconData getIconData(String? iconName) {
    return _iconMap[iconName] ?? Icons.category_rounded;
  }
}
