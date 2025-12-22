import 'package:flutter/foundation.dart';
import 'package:children_rewards/core/usecases/usecases.dart';
import 'package:children_rewards/features/children/domain/repositories/i_children_repository.dart';

/// 删除宝贝用例参数
@immutable
class DeleteChildParams {
  /// 宝贝ID
  final int childId;

  const DeleteChildParams({required this.childId});
}

/// 删除宝贝用例
///
/// 处理删除宝贝档案的业务逻辑（软删除）：
/// 1. 验证宝贝存在
/// 2. 执行软删除
class DeleteChildUseCase extends UseCase<DeleteChildParams, bool> {
  final IChildrenRepository _childrenRepository;

  DeleteChildUseCase(this._childrenRepository);

  @override
  Future<Result<bool>> execute(DeleteChildParams params) async {
    try {
      // 验证宝贝存在
      final existing = await _childrenRepository.getChild(params.childId);
      if (existing == null) {
        return Result.failure('宝贝档案不存在');
      }

      final deletedCount = await _childrenRepository.deleteChild(params.childId);

      if (deletedCount > 0) {
        return Result.success(true);
      } else {
        return Result.failure('删除失败');
      }
    } catch (e, stackTrace) {
      return Result.failure('删除失败：${e.toString()}', stackTrace: stackTrace);
    }
  }
}
