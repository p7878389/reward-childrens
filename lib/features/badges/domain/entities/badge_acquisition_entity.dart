import 'package:flutter/foundation.dart';

@immutable
class BadgeAcquisitionEntity {
  final int id;
  final int childId;
  final int badgeId;
  final String badgeSnapshot;
  final int bonusPointsAwarded;
  final int? pointRecordId;
  final int? triggerValue;
  final String? note;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const BadgeAcquisitionEntity({
    required this.id,
    required this.childId,
    required this.badgeId,
    required this.badgeSnapshot,
    required this.bonusPointsAwarded,
    this.pointRecordId,
    this.triggerValue,
    this.note,
    this.isDeleted = false,
    required this.createdAt,
    this.updatedAt,
  });

  bool get hasBonusPoints => bonusPointsAwarded > 0;
}
