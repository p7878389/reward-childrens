import 'package:flutter/foundation.dart';

/// 规则类型枚举
enum RuleType {
  reward,
  penalty;

  /// 从字符串转换为枚举
  static RuleType fromString(String value) {
    return RuleType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => RuleType.reward,
    );
  }
}

/// 积分规则领域实体
///
/// 代表应用中的积分规则概念，可以是奖励规则或惩罚规则。
/// 这是一个不可变类，遵循DDD领域实体设计原则。
@immutable
class RuleEntity {
  /// 唯一标识符
  final int id;

  /// 关联的宝贝ID（可选，null表示全局规则）
  final int? childId;

  /// 规则名称
  final String name;

  /// 图标标识
  final String icon;

  /// 积分值（始终为正数）
  final int points;

  /// 规则类型
  final RuleType type;

  /// 是否激活
  final bool isActive;

  /// 是否为系统规则
  final bool isSystem;

  /// 是否可编辑
  final bool isEditable;

  /// 是否已删除（软删除标记）
  final bool isDeleted;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime? updatedAt;

  const RuleEntity({
    required this.id,
    this.childId,
    required this.name,
    required this.icon,
    required this.points,
    required this.type,
    required this.isActive,
    required this.isSystem,
    required this.isEditable,
    required this.isDeleted,
    required this.createdAt,
    this.updatedAt,
  });

  /// 检查规则是否可用（激活且未删除）
  bool get isAvailable => isActive && !isDeleted;

  /// 检查规则是否为奖励类型
  bool get isRewardType => type == RuleType.reward;

  /// 检查规则是否为惩罚类型
  bool get isPenaltyType => type == RuleType.penalty;

  /// 获取应用规则后的积分变化值
  /// 奖励规则返回正数，惩罚规则返回负数
  int get pointsDelta => isRewardType ? points : -points;

  /// 创建一个更新了激活状态的新实例
  RuleEntity withActiveStatus(bool active) {
    return RuleEntity(
      id: id,
      childId: childId,
      name: name,
      icon: icon,
      points: points,
      type: type,
      isActive: active,
      isSystem: isSystem,
      isEditable: isEditable,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// 创建一个更新了信息的新实例
  RuleEntity copyWith({
    String? name,
    String? icon,
    int? points,
    RuleType? type,
    bool? isActive,
    bool? isDeleted,
    DateTime? updatedAt,
  }) {
    return RuleEntity(
      id: id,
      childId: childId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      points: points ?? this.points,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      isSystem: isSystem,
      isEditable: isEditable,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RuleEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'RuleEntity(id: $id, name: $name, type: $type, points: $points, isActive: $isActive)';
  }
}
