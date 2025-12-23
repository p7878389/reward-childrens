import 'package:flutter/foundation.dart';

@immutable
class CheckinEntity {
  final int id;
  final int childId;
  final String checkinDate;
  final int streakDays;
  final int? pointRecordId;
  final bool isDeleted;
  final DateTime createdAt;

  const CheckinEntity({
    required this.id,
    required this.childId,
    required this.checkinDate,
    required this.streakDays,
    this.pointRecordId,
    this.isDeleted = false,
    required this.createdAt,
  });
}
