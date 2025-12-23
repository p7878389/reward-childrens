import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/features/points/domain/models/point_record_detail.dart';

/// 积分记录数据仓库接口
///
/// 定义积分记录的 CRUD 操作抽象
abstract class IPointRecordsRepository {
  /// 监听积分记录
  Stream<List<PointRecord>> watchRecords(int childId, {String? filterType});

  /// 分页查询积分记录
  Future<List<PointRecordDetail>> getRecordsPaged({
    required int childId,
    String? filterType,
    required int limit,
    required int offset,
  });

  /// 获取积分记录总数
  Future<int> getRecordsCount(int childId, {String? filterType});

  /// 获取统计信息（earned/spent 总计）
  Future<Map<String, int>> getStats(int childId);

  /// 添加积分记录（同时更新宝贝星星数）
  Future<void> addRecord({
    required int childId,
    required int points,
    required String type,
    int? ruleId,
    String? ruleName,
    String? note,
  });

  /// 添加积分记录并返回记录 ID
  Future<int> addRecordAndReturnId({
    required int childId,
    required int points,
    required String type,
    int? ruleId,
    String? ruleName,
    String? note,
  });
}
