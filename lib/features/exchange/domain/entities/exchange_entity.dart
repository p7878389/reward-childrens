import 'package:flutter/foundation.dart';

/// 兑换记录领域实体
///
/// 代表一次商品兑换交易记录，包含兑换时的商品快照信息。
/// 这是一个不可变类，遵循DDD领域实体设计原则。
@immutable
class ExchangeEntity {
  /// 唯一标识符
  final int id;

  /// 关联的宝贝ID
  final int childId;

  /// 关联的商品ID
  final int rewardId;

  /// 兑换时的商品名称快照
  final String rewardSnapshot;

  /// 花费的积分
  final int pointsSpent;

  /// 备注（可选）
  final String? note;

  /// 是否已删除（软删除标记）
  final bool isDeleted;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime? updatedAt;

  const ExchangeEntity({
    required this.id,
    required this.childId,
    required this.rewardId,
    required this.rewardSnapshot,
    required this.pointsSpent,
    this.note,
    required this.isDeleted,
    required this.createdAt,
    this.updatedAt,
  });

  /// 检查是否为有效记录（未删除）
  bool get isValid => !isDeleted;

  /// 获取格式化的兑换信息
  String get displayInfo => '$rewardSnapshot (-$pointsSpent ⭐)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExchangeEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ExchangeEntity(id: $id, childId: $childId, rewardSnapshot: $rewardSnapshot, pointsSpent: $pointsSpent)';
  }
}
