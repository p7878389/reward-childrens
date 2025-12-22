import 'package:children_rewards/core/database/app_database.dart';

/// 宝贝数据仓库接口
///
/// 定义宝贝数据的 CRUD 操作抽象，支持 Mock 测试和实现替换
abstract class IChildrenRepository {
  /// 监听所有宝贝列表（排除已删除）
  Stream<List<ChildrenData>> watchAllChildren();

  /// 根据 ID 获取宝贝
  Future<ChildrenData?> getChild(int id);

  /// 监听单个宝贝的变化
  Stream<ChildrenData?> watchChild(int id);

  /// 创建宝贝
  Future<int> createChild({
    required String name,
    required String gender,
    String? avatar,
    String? birthday,
  });

  /// 更新宝贝信息
  Future<bool> updateChild(ChildrenData child);

  /// 删除宝贝（软删除）
  Future<int> deleteChild(int id);
}
