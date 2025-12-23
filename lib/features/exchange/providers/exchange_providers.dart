import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';
import 'package:children_rewards/features/exchange/data/exchange_repository.dart';
import 'package:children_rewards/features/exchange/domain/usecases/exchange_reward_usecase.dart';
import 'package:children_rewards/features/badges/providers/badge_providers.dart';

/// 兑换仓库 Provider
final exchangeRepositoryProvider = Provider<ExchangeRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ExchangeRepository(db);
});

/// 兑换记录流 Provider
final exchangesStreamProvider = StreamProvider.family<List<Exchange>, int>((ref, childId) {
  return ref.watch(exchangeRepositoryProvider).watchExchanges(childId);
});

/// 兑换奖励用例 Provider
final exchangeRewardUseCaseProvider = Provider<ExchangeRewardUseCase>((ref) {
  final repository = ref.watch(exchangeRepositoryProvider);
  final checkBadgesUseCase = ref.watch(checkAndAwardBadgesUseCaseProvider);
  return ExchangeRewardUseCase(repository, checkBadgesUseCase);
});