import 'package:flutter/foundation.dart';

enum BadgeTriggerType {
  totalPoints('total_points'),
  consecutiveCheckin('consecutive_checkin'),
  exchangeCount('exchange_count'),
  pointsEarnedSingle('points_earned_single'),
  custom('custom');

  final String value;
  const BadgeTriggerType(this.value);

  static BadgeTriggerType fromString(String value) {
    return BadgeTriggerType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => BadgeTriggerType.custom,
    );
  }
}

@immutable
class BadgeEntity {
  final int id;
  final String name;
  final String? description;
  final String icon;
  final int level;
  final BadgeTriggerType triggerType;
  final int triggerThreshold;
  final Map<String, dynamic>? triggerConfig;
  final int bonusPoints;
  final int sortOrder;
  final bool isActive;
  final bool isSystem;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const BadgeEntity({
    required this.id,
    required this.name,
    this.description,
    required this.icon,
    this.level = 1,
    required this.triggerType,
    required this.triggerThreshold,
    this.triggerConfig,
    this.bonusPoints = 0,
    this.sortOrder = 0,
    this.isActive = true,
    this.isSystem = false,
    this.isDeleted = false,
    required this.createdAt,
    this.updatedAt,
  });

  bool get isValid => isActive && !isDeleted;

  String get triggerDescription {
    switch (triggerType) {
      case BadgeTriggerType.totalPoints:
        return '累计获得 $triggerThreshold 颗星星';
      case BadgeTriggerType.consecutiveCheckin:
        return '连续签到 $triggerThreshold 天';
      case BadgeTriggerType.exchangeCount:
        return '兑换商品 $triggerThreshold 次';
      case BadgeTriggerType.pointsEarnedSingle:
        return '单次获得 $triggerThreshold 颗星星';
      case BadgeTriggerType.custom:
        return description ?? '完成特定任务';
    }
  }
}
