import 'package:children_rewards/features/badges/domain/entities/badge_acquisition_entity.dart';

abstract class IBadgeAcquisitionRepository {
  Future<List<BadgeAcquisitionEntity>> getChildAcquisitions(int childId);
  Future<Set<int>> getAcquiredBadgeIds(int childId);
  Future<int> create({
    required int childId,
    required int badgeId,
    required String badgeSnapshot,
    required int bonusPointsAwarded,
    int? pointRecordId,
    int? triggerValue,
    String? note,
  });
}
