import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';
import 'package:children_rewards/shared/providers/pagination_provider.dart';
import 'package:children_rewards/features/rule/data/rules_repository.dart';

/// 规则仓库 Provider
final rulesRepositoryProvider = Provider<RulesRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return RulesRepository(db);
});

/// 规则流 Provider（按类型）
final rulesStreamProvider = StreamProvider.family<List<Rule>, String>((ref, type) {
  final repository = ref.watch(rulesRepositoryProvider);
  return repository.watchRulesByType(type);
});

/// 规则分页 Notifier
class RulesPaginationNotifier extends PaginationNotifier<Rule, String> {
  final RulesRepository _repository;

  RulesPaginationNotifier(this._repository) : super(pageSize: 20);

  @override
  Future<List<Rule>> fetchPage(int page, int pageSize, String? filter) {
    return _repository.getRulesPaged(
      type: filter ?? 'reward',
      limit: pageSize,
      offset: page * pageSize,
    );
  }
}

/// 规则分页 Provider
final rulesPaginationProvider =
    StateNotifierProvider.autoDispose<RulesPaginationNotifier, PaginationState<Rule>>((ref) {
  final repository = ref.watch(rulesRepositoryProvider);
  return RulesPaginationNotifier(repository);
});
