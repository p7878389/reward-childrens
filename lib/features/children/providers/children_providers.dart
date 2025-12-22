import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/features/children/data/children_repository.dart';
import 'package:children_rewards/features/children/domain/usecases/create_child_usecase.dart';
import 'package:children_rewards/features/children/domain/usecases/update_child_usecase.dart';
import 'package:children_rewards/features/children/domain/usecases/delete_child_usecase.dart';

/// 监听所有宝贝列表
final allChildrenStreamProvider = StreamProvider<List<ChildrenData>>((ref) {
  final repository = ref.watch(childrenRepositoryProvider);
  return repository.watchAllChildren();
});

/// 监听单个宝贝
final childStreamProvider = StreamProvider.family<ChildrenData?, int>((ref, id) {
  final repository = ref.watch(childrenRepositoryProvider);
  return repository.watchChild(id);
});

/// 创建宝贝用例 Provider
final createChildUseCaseProvider = Provider<CreateChildUseCase>((ref) {
  final repository = ref.watch(childrenRepositoryProvider);
  return CreateChildUseCase(repository);
});

/// 更新宝贝用例 Provider
final updateChildUseCaseProvider = Provider<UpdateChildUseCase>((ref) {
  final repository = ref.watch(childrenRepositoryProvider);
  return UpdateChildUseCase(repository);
});

/// 删除宝贝用例 Provider
final deleteChildUseCaseProvider = Provider<DeleteChildUseCase>((ref) {
  final repository = ref.watch(childrenRepositoryProvider);
  return DeleteChildUseCase(repository);
});