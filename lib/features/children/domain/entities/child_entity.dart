import 'package:flutter/foundation.dart';

/// 宝贝性别枚举
enum Gender {
  boy,
  girl;

  /// 从字符串转换为枚举
  static Gender fromString(String value) {
    return Gender.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Gender.boy,
    );
  }
}

/// 宝贝领域实体
///
/// 代表应用中的宝贝概念，包含基本信息和积分余额。
/// 这是一个不可变类，遵循DDD领域实体设计原则。
@immutable
class ChildEntity {
  /// 唯一标识符
  final int id;

  /// 宝贝姓名
  final String name;

  /// 头像路径（可选）
  final String? avatar;

  /// 性别
  final Gender gender;

  /// 生日（可选）
  final String? birthday;

  /// 当前星星（积分）余额
  final int stars;

  /// 是否已删除（软删除标记）
  final bool isDeleted;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;

  const ChildEntity({
    required this.id,
    required this.name,
    this.avatar,
    required this.gender,
    this.birthday,
    required this.stars,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 检查宝贝是否有足够的积分
  bool hasEnoughStars(int required) => stars >= required;

  /// 检查是否为活跃状态（未删除）
  bool get isActive => !isDeleted;

  /// 创建一个更新了积分的新实例
  ChildEntity withStars(int newStars) {
    return ChildEntity(
      id: id,
      name: name,
      avatar: avatar,
      gender: gender,
      birthday: birthday,
      stars: newStars,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// 创建一个更新了基本信息的新实例
  ChildEntity copyWith({
    String? name,
    String? avatar,
    Gender? gender,
    String? birthday,
    int? stars,
    bool? isDeleted,
    DateTime? updatedAt,
  }) {
    return ChildEntity(
      id: id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      stars: stars ?? this.stars,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChildEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ChildEntity(id: $id, name: $name, gender: $gender, stars: $stars)';
  }
}
