import 'package:flutter/foundation.dart';

/// 商品分类枚举
enum RewardCategory {
  toy,
  game,
  food,
  activity,
  privilege,
  other;

  /// 从字符串转换为枚举
  static RewardCategory fromString(String value) {
    return RewardCategory.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => RewardCategory.other,
    );
  }
}

/// 奖励商品领域实体
///
/// 代表应用中可兑换的奖励商品，包含价格、库存等信息。
/// 这是一个不可变类，遵循DDD领域实体设计原则。
@immutable
class RewardEntity {
  /// 唯一标识符
  final int id;

  /// 商品名称
  final String name;

  /// 商品描述（可选）
  final String? description;

  /// 商品图片路径（可选）
  final String? image;

  /// 价格（积分）
  final int price;

  /// 分类
  final RewardCategory category;

  /// 库存数量（null表示无限）
  final int? stock;

  /// 是否激活
  final bool isActive;

  /// 是否已删除（软删除标记）
  final bool isDeleted;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime? updatedAt;

  const RewardEntity({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.price,
    required this.category,
    this.stock,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    this.updatedAt,
  });

  /// 检查商品是否可兑换（激活、未删除且有库存）
  bool get canExchange => isActive && !isDeleted && hasStock;

  /// 检查是否有库存
  bool get hasStock => stock == null || stock! > 0;

  /// 检查是否为无限库存
  bool get hasUnlimitedStock => stock == null;

  /// 检查给定积分是否足够购买
  bool isAffordable(int availableStars) => availableStars >= price;

  /// 创建一个扣减库存后的新实例
  RewardEntity withDecreasedStock() {
    if (stock == null) return this;
    return RewardEntity(
      id: id,
      name: name,
      description: description,
      image: image,
      price: price,
      category: category,
      stock: stock! - 1,
      isActive: isActive,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// 创建一个更新了激活状态的新实例
  RewardEntity withActiveStatus(bool active) {
    return RewardEntity(
      id: id,
      name: name,
      description: description,
      image: image,
      price: price,
      category: category,
      stock: stock,
      isActive: active,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// 创建一个更新了信息的新实例
  RewardEntity copyWith({
    String? name,
    String? description,
    String? image,
    int? price,
    RewardCategory? category,
    int? stock,
    bool? isActive,
    bool? isDeleted,
    DateTime? updatedAt,
  }) {
    return RewardEntity(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RewardEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'RewardEntity(id: $id, name: $name, price: $price, stock: $stock, isActive: $isActive)';
  }
}
