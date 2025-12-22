import 'package:children_rewards/core/database/app_database.dart';

/// 规则数据仓库接口
///
/// 定义规则数据的 CRUD 操作抽象
abstract class IRulesRepository {
  /// 监听指定类型的规则列表
  Stream<List<Rule>> watchRulesByType(String type);

  /// 获取指定类型的规则列表
  Future<List<Rule>> getRulesByType(String type);

  /// 分页查询规则
  Future<List<Rule>> getRulesPaged({
    required String type,
    required int limit,
    required int offset,
  });

  /// 获取规则总数
  Future<int> getRulesCount(String type);

  /// 创建规则
  Future<int> createRule({
    required String name,
    required String type,
    required int points,
    String? icon,
  });

  /// 切换规则状态
  Future<void> toggleRuleStatus(int id, bool isActive);

  /// 删除规则（软删除）
  Future<void> deleteRule(int id);

  /// 更新规则
  Future<void> updateRule({
    required int id,
    required String name,
    required int points,
    required String icon,
  });

  /// 检查规则名称是否已存在
  Future<bool> isRuleNameExists(String name, {int? excludeId});
}
