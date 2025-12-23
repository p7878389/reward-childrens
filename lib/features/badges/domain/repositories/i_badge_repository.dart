import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';

abstract class IBadgeRepository {
  Future<List<BadgeEntity>> getActiveBadges();
  Future<List<BadgeEntity>> getAllBadges();
  Future<BadgeEntity?> getBadge(int id);
  Future<int> create(BadgeEntity badge);
  Future<bool> update(BadgeEntity badge);
  Future<bool> delete(int id);
}
