import 'package:flutter/foundation.dart';
import 'package:children_rewards/core/usecases/usecases.dart';
import 'package:children_rewards/features/points/domain/repositories/i_point_records_repository.dart';

/// 应用规则用例参数
@immutable
class ApplyRuleParams {
  /// 宝贝ID
  final int childId;

  /// 积分值（正数）
  final int points;

  /// 积分类型：'earned' 或 'deducted'
  final String type;

  /// 规则ID（可选）
  final int? ruleId;

  /// 规则名称（可选，冗余存储）
  final String? ruleName;

  /// 备注（可选）
  final String? note;

  const ApplyRuleParams({
    required this.childId,
    required this.points,
    required this.type,
    this.ruleId,
    this.ruleName,
    this.note,
  });

  /// 创建奖励积分参数
  factory ApplyRuleParams.reward({
    required int childId,
    required int points,
    int? ruleId,
    String? ruleName,
    String? note,
  }) {
    return ApplyRuleParams(
      childId: childId,
      points: points,
      type: 'earned',
      ruleId: ruleId,
      ruleName: ruleName,
      note: note,
    );
  }

  /// 创建扣除积分参数
  factory ApplyRuleParams.deduct({
    required int childId,
    required int points,
    int? ruleId,
    String? ruleName,
    String? note,
  }) {
    return ApplyRuleParams(
      childId: childId,
      points: points,
      type: 'deducted',
      ruleId: ruleId,
      ruleName: ruleName,
      note: note,
    );
  }
}

/// 应用规则用例
///
/// 处理积分的增加或扣除操作：
/// 1. 创建积分记录
/// 2. 更新宝贝的积分余额
///
/// 所有操作在事务中执行，保证数据一致性。
class ApplyRuleUseCase extends UseCase<ApplyRuleParams, void> {
  final IPointRecordsRepository _pointRecordsRepository;

  ApplyRuleUseCase(this._pointRecordsRepository);

  @override
  Future<Result<void>> execute(ApplyRuleParams params) async {
    try {
      // 验证参数
      if (params.points <= 0) {
        return Result.failure('积分值必须大于0');
      }

      if (params.type != 'earned' && params.type != 'deducted') {
        return Result.failure('无效的积分类型');
      }

      await _pointRecordsRepository.addRecord(
        childId: params.childId,
        points: params.points,
        type: params.type,
        ruleId: params.ruleId,
        ruleName: params.ruleName,
        note: params.note,
      );

      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure('积分操作失败：${e.toString()}', stackTrace: stackTrace);
    }
  }
}
