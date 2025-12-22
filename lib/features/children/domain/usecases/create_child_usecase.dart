import 'package:flutter/foundation.dart';
import 'package:children_rewards/core/usecases/usecases.dart';
import 'package:children_rewards/features/children/domain/repositories/i_children_repository.dart';

/// 创建宝贝用例参数
@immutable
class CreateChildParams {
  /// 宝贝姓名
  final String name;

  /// 性别：'boy' 或 'girl'
  final String gender;

  /// 头像路径（可选）
  final String? avatar;

  /// 生日（可选）
  final String? birthday;

  const CreateChildParams({
    required this.name,
    required this.gender,
    this.avatar,
    this.birthday,
  });
}

/// 创建宝贝用例
///
/// 处理创建新宝贝档案的业务逻辑：
/// 1. 验证姓名不为空
/// 2. 验证性别有效
/// 3. 创建宝贝记录
class CreateChildUseCase extends UseCase<CreateChildParams, int> {
  final IChildrenRepository _childrenRepository;

  CreateChildUseCase(this._childrenRepository);

  @override
  Future<Result<int>> execute(CreateChildParams params) async {
    try {
      // 验证姓名
      if (params.name.trim().isEmpty) {
        return Result.failure('姓名不能为空');
      }

      // 验证性别
      if (params.gender != 'boy' && params.gender != 'girl') {
        return Result.failure('无效的性别');
      }

      final childId = await _childrenRepository.createChild(
        name: params.name.trim(),
        gender: params.gender,
        avatar: params.avatar,
        birthday: params.birthday,
      );

      return Result.success(childId);
    } catch (e, stackTrace) {
      return Result.failure('创建失败：${e.toString()}', stackTrace: stackTrace);
    }
  }
}
