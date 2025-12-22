import 'package:flutter/foundation.dart';
import 'package:children_rewards/core/usecases/usecases.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/features/children/domain/repositories/i_children_repository.dart';

/// 更新宝贝用例参数
@immutable
class UpdateChildParams {
  /// 要更新的宝贝数据
  final ChildrenData child;

  const UpdateChildParams({required this.child});
}

/// 更新宝贝用例
///
/// 处理更新宝贝档案的业务逻辑：
/// 1. 验证宝贝存在
/// 2. 验证数据有效性
/// 3. 更新宝贝记录
class UpdateChildUseCase extends UseCase<UpdateChildParams, bool> {
  final IChildrenRepository _childrenRepository;

  UpdateChildUseCase(this._childrenRepository);

  @override
  Future<Result<bool>> execute(UpdateChildParams params) async {
    try {
      // 验证姓名
      if (params.child.name.trim().isEmpty) {
        return Result.failure('姓名不能为空');
      }

      // 验证宝贝存在
      final existing = await _childrenRepository.getChild(params.child.id);
      if (existing == null) {
        return Result.failure('宝贝档案不存在');
      }

      final success = await _childrenRepository.updateChild(params.child);

      if (success) {
        return Result.success(true);
      } else {
        return Result.failure('更新失败');
      }
    } catch (e, stackTrace) {
      return Result.failure('更新失败：${e.toString()}', stackTrace: stackTrace);
    }
  }
}
