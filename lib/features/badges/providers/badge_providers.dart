import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';
import 'package:children_rewards/features/badges/data/badge_repository.dart';
import 'package:children_rewards/features/badges/data/badge_acquisition_repository.dart';
import 'package:children_rewards/features/badges/data/checkin_repository.dart';
import 'package:children_rewards/features/badges/domain/evaluators/badge_evaluator_factory.dart';
import 'package:children_rewards/features/badges/domain/evaluators/total_points_evaluator.dart';
import 'package:children_rewards/features/badges/domain/evaluators/consecutive_checkin_evaluator.dart';
import 'package:children_rewards/features/badges/domain/evaluators/exchange_count_evaluator.dart';
import 'package:children_rewards/features/badges/domain/evaluators/single_points_evaluator.dart';
import 'package:children_rewards/features/badges/domain/services/badge_detection_service.dart';
import 'package:children_rewards/features/badges/domain/usecases/award_badge_usecase.dart';
import 'package:children_rewards/features/badges/domain/usecases/check_and_award_badges_usecase.dart';
import 'package:children_rewards/features/points/providers/point_records_providers.dart';
import 'package:children_rewards/features/exchange/providers/exchange_providers.dart';
import 'package:children_rewards/features/badges/domain/usecases/checkin_usecase.dart';
import 'package:children_rewards/features/badges/domain/usecases/get_child_badges_usecase.dart';
import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';

/// 徽章仓库 Provider
final badgeRepositoryProvider = Provider<BadgeRepository>((ref) {
  return BadgeRepository(ref.watch(databaseProvider));
});

/// 徽章获得记录仓库 Provider
final badgeAcquisitionRepositoryProvider = Provider<BadgeAcquisitionRepository>((ref) {
  return BadgeAcquisitionRepository(ref.watch(databaseProvider));
});

/// 签到仓库 Provider
final checkinRepositoryProvider = Provider<CheckinRepository>((ref) {
  return CheckinRepository(ref.watch(databaseProvider));
});

/// 评估器工厂 Provider
final badgeEvaluatorFactoryProvider = Provider<BadgeEvaluatorFactory>((ref) {
  final factory = BadgeEvaluatorFactory();
  factory.register(TotalPointsEvaluator(ref.watch(pointRecordsRepositoryProvider)));
  factory.register(ConsecutiveCheckinEvaluator(ref.watch(checkinRepositoryProvider)));
  factory.register(ExchangeCountEvaluator(ref.watch(exchangeRepositoryProvider)));
  factory.register(SinglePointsEvaluator());
  return factory;
});

/// 徽章检测服务 Provider
final badgeDetectionServiceProvider = Provider<BadgeDetectionService>((ref) {
  return BadgeDetectionService(
    ref.watch(badgeRepositoryProvider),
    ref.watch(badgeAcquisitionRepositoryProvider),
    ref.watch(badgeEvaluatorFactoryProvider),
  );
});

/// 授予徽章用例 Provider
final awardBadgeUseCaseProvider = Provider<AwardBadgeUseCase>((ref) {
  return AwardBadgeUseCase(
    ref.watch(badgeAcquisitionRepositoryProvider),
    ref.watch(pointRecordsRepositoryProvider),
  );
});

/// 获取孩子徽章用例 Provider
final getChildBadgesUseCaseProvider = Provider<GetChildBadgesUseCase>((ref) {
  return GetChildBadgesUseCase(
    ref.watch(badgeRepositoryProvider),
    ref.watch(badgeAcquisitionRepositoryProvider),
    ref.watch(badgeEvaluatorFactoryProvider),
  );
});

/// 孩子徽章列表 Provider
final childBadgesProvider = FutureProvider.family<List<ChildBadgeDisplay>, int>((ref, childId) async {
  final useCase = ref.watch(getChildBadgesUseCaseProvider);
  final result = await useCase.execute(GetChildBadgesParams(childId: childId));
  return result.dataOrNull ?? [];
});

/// 孩子已获得徽章 Provider
final childAcquiredBadgesProvider = FutureProvider.family<List<ChildBadgeDisplay>, int>((ref, childId) async {
  final useCase = ref.watch(getChildBadgesUseCaseProvider);
  final result = await useCase.execute(GetChildBadgesParams(
    childId: childId,
    acquiredOnly: true,
  ));
  return result.dataOrNull ?? [];
});

/// 签到用例 Provider
final checkinUseCaseProvider = Provider<CheckinUseCase>((ref) {
  return CheckinUseCase(
    ref.watch(checkinRepositoryProvider),
    ref.watch(pointRecordsRepositoryProvider),
    ref.watch(checkAndAwardBadgesUseCaseProvider),
  );
});

/// 检测并授予徽章用例 Provider

final checkAndAwardBadgesUseCaseProvider = Provider<CheckAndAwardBadgesUseCase>((ref) {

  return CheckAndAwardBadgesUseCase(

    ref.watch(badgeDetectionServiceProvider),

    ref.watch(awardBadgeUseCaseProvider),

  );

});



/// 所有徽章流 Provider
final allBadgesStreamProvider = StreamProvider<List<BadgeEntity>>((ref) async* {
  final repo = ref.watch(badgeRepositoryProvider);
  // Initial load
  yield await repo.getAllBadges();
});
