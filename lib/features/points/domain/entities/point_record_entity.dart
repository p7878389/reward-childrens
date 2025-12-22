import 'package:flutter/foundation.dart';

/// 积分记录类型枚举
enum PointRecordType {
  earned,
  deducted,
  spent;

  /// 从字符串转换为枚举
  static PointRecordType fromString(String value) {
    return PointRecordType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PointRecordType.earned,
    );
  }
}

/// 积分记录领域实体
///
/// 代表一条积分变动流水记录。
/// 这是一个不可变类，遵循DDD领域实体设计原则。
@immutable
class PointRecordEntity {
  /// 唯一标识符
  final int id;

  /// 关联的宝贝ID
  final int childId;

  /// 关联的规则ID（可选）
  final int? ruleId;

  /// 关联的兑换ID（可选）
  final int? exchangeId;

  /// 积分变动值（正数表示获得，负数表示消费/扣除）
  final int points;

  /// 记录类型
  final PointRecordType type;

  /// 备注（可选）
  final String? note;

  /// 是否已删除（软删除标记）
  final bool isDeleted;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime? updatedAt;

  const PointRecordEntity({
    required this.id,
    required this.childId,
    this.ruleId,
    this.exchangeId,
    required this.points,
    required this.type,
    this.note,
    required this.isDeleted,
    required this.createdAt,
    this.updatedAt,
  });

  /// 检查是否为获得积分记录
  bool get isEarned => type == PointRecordType.earned;

  /// 检查是否为消费积分记录
  bool get isSpent => type == PointRecordType.spent;

  /// 检查是否为扣除积分记录
  bool get isDeducted => type == PointRecordType.deducted;

  /// 检查是否为正向积分（获得）
  bool get isPositive => points > 0;

  /// 检查是否为负向积分（消费或扣除）
  bool get isNegative => points < 0;

  /// 获取积分绝对值
  int get absolutePoints => points.abs();

  /// 获取格式化的积分显示
  String get displayPoints => isPositive ? '+$points' : '$points';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PointRecordEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'PointRecordEntity(id: $id, childId: $childId, points: $points, type: $type)';
  }
}
