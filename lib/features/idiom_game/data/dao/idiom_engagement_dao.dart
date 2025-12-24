import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/database/tables.dart';
import 'package:drift/drift.dart';

part 'idiom_engagement_dao.g.dart';

class MistakeStats {
  final int toReviewCount;
  final int masteredCount;
  final int totalMistakes;

  MistakeStats({
    required this.toReviewCount,
    required this.masteredCount,
    required this.totalMistakes,
  });
}

class MistakeDetail {
  final IdiomEngagementRecord record;
  final Idiom idiom;
  
  MistakeDetail({required this.record, required this.idiom});
}

@DriftAccessor(tables: [IdiomEngagementRecords, Idioms])
class IdiomEngagementDao extends DatabaseAccessor<AppDatabase> with _$IdiomEngagementDaoMixin {
  IdiomEngagementDao(super.attachedDatabase);

  /// 获取单个成语的互动记录
  Future<IdiomEngagementRecord?> getEngagement(int childId, int idiomId) {
    return (select(idiomEngagementRecords)
          ..where((t) => t.childId.equals(childId))
          ..where((t) => t.idiomId.equals(idiomId)))
        .getSingleOrNull();
  }

  /// 更新或插入互动记录 (包含 SRS 逻辑)
  Future<void> upsertEngagement(int childId, int idiomId, {required bool isCorrect}) async {
    final existing = await getEngagement(childId, idiomId);
    final now = DateTime.now();
    
    if (existing != null) {
      // SRS Logic
      int newMasteryLevel = existing.masteryLevel;
      int newConsecutiveCorrect = existing.consecutiveCorrect;

      if (isCorrect) {
        newConsecutiveCorrect++;
        // 简单升级逻辑: 连续答对 N 次即为 N 级 (最高 3)
        if (newConsecutiveCorrect >= 3) {
          newMasteryLevel = 3;
        } else if (newConsecutiveCorrect >= 2) {
          newMasteryLevel = 2;
        } else if (newConsecutiveCorrect >= 1) {
          newMasteryLevel = 1;
        }
      } else {
        newConsecutiveCorrect = 0;
        // 降级逻辑: 3->2, 2->1, 1->0
        if (newMasteryLevel > 0) {
          newMasteryLevel--;
        }
      }

      final companion = IdiomEngagementRecordsCompanion(
        id: Value(existing.id),
        encounterCount: Value(existing.encounterCount + 1),
        correctCount: isCorrect ? Value(existing.correctCount + 1) : Value(existing.correctCount),
        failCount: !isCorrect ? Value(existing.failCount + 1) : Value(existing.failCount),
        lastEncounteredAt: Value(now),
        lastWrongAt: !isCorrect ? Value(now) : const Value.absent(),
        masteryLevel: Value(newMasteryLevel),
        consecutiveCorrect: Value(newConsecutiveCorrect),
      );
      await (update(idiomEngagementRecords)..where((t) => t.id.equals(existing.id))).write(companion);
    } else {
      // 插入新记录
      await into(idiomEngagementRecords).insert(
        IdiomEngagementRecordsCompanion.insert(
          childId: childId,
          idiomId: idiomId,
          encounterCount: const Value(1),
          correctCount: Value(isCorrect ? 1 : 0),
          failCount: Value(!isCorrect ? 1 : 0),
          lastEncounteredAt: now,
          lastWrongAt: !isCorrect ? Value(now) : const Value.absent(),
          masteryLevel: Value(isCorrect ? 1 : 0), // 第一次对=初识, 错=未掌握
          consecutiveCorrect: Value(isCorrect ? 1 : 0),
        ),
      );
    }
  }

  /// 获取错题统计
  Future<MistakeStats> getMistakeStats(int childId) async {
    // 待复习: 曾错过 (failCount > 0) 且 未完全掌握 (masteryLevel < 3)
    final reviewQuery = selectOnly(idiomEngagementRecords)
      ..addColumns([idiomEngagementRecords.id.count()])
      ..where(idiomEngagementRecords.childId.equals(childId))
      ..where(idiomEngagementRecords.failCount.isBiggerThanValue(0))
      ..where(idiomEngagementRecords.masteryLevel.isSmallerThanValue(3));
    
    final reviewCount = await reviewQuery.map((row) => row.read(idiomEngagementRecords.id.count())!).getSingle();

    // 已掌握: 曾错过 且 已掌握 (masteryLevel == 3)
    final masteredQuery = selectOnly(idiomEngagementRecords)
      ..addColumns([idiomEngagementRecords.id.count()])
      ..where(idiomEngagementRecords.childId.equals(childId))
      ..where(idiomEngagementRecords.failCount.isBiggerThanValue(0))
      ..where(idiomEngagementRecords.masteryLevel.equals(3));

    final masteredCount = await masteredQuery.map((row) => row.read(idiomEngagementRecords.id.count())!).getSingle();

    return MistakeStats(
      toReviewCount: reviewCount,
      masteredCount: masteredCount,
      totalMistakes: reviewCount + masteredCount,
    );
  }

  /// 获取复习队列 (智能排序)
  Future<List<int>> getReviewQueue(int childId, {int limit = 10}) async {
    // 1. 获取所有待复习的记录 (mastery < 3 且 failCount > 0)
    final records = await (select(idiomEngagementRecords)
      ..where((t) => t.childId.equals(childId))
      ..where((t) => t.failCount.isBiggerThanValue(0))
      ..where((t) => t.masteryLevel.isSmallerThanValue(3))
    ).get();

    if (records.isEmpty) return [];

    // 2. 内存中计算优先级
    final now = DateTime.now();
    
    // 创建包含权重的临时对象
    final scoredRecords = records.map((record) {
      double score = 0;

      // A. 基础分
      switch (record.masteryLevel) {
        case 0: score += 100; break; // 未掌握
        case 1: score += 60; break;  // 初识
        case 2: score += 30; break;  // 熟悉
        default: score += 0;
      }

      // B. 时间衰减
      if (record.lastWrongAt != null) {
        final daysSinceWrong = now.difference(record.lastWrongAt!).inDays;
        if (daysSinceWrong < 1) {
          score += 20; 
        } else if (daysSinceWrong <= 3) {
          score += 10;
        }
      }
      
      // C. 防遗忘
      final daysSinceLast = now.difference(record.lastEncounteredAt).inDays;
      if (record.masteryLevel > 0 && daysSinceLast > 7) {
        score += 15;
      }

      // D. 错误权重
      score += (record.failCount * 5);

      return MapEntry(record, score);
    }).toList();

    // 3. 排序
    scoredRecords.sort((a, b) => b.value.compareTo(a.value));

    // 4. 取 Top N 并返回 ID
    return scoredRecords.take(limit).map((e) => e.key.idiomId).toList();
  }

  /// 获取错题列表 (包含成语详情)
  Future<List<MistakeDetail>> getMistakeList(int childId, {int limit = 20, int offset = 0}) async {
    final query = select(idiomEngagementRecords).join([
      innerJoin(idioms, idioms.id.equalsExp(idiomEngagementRecords.idiomId)),
    ])
      ..where(idiomEngagementRecords.childId.equals(childId))
      ..where(idiomEngagementRecords.failCount.isBiggerThanValue(0))
      ..orderBy([OrderingTerm.asc(idiomEngagementRecords.masteryLevel), OrderingTerm.desc(idiomEngagementRecords.lastWrongAt)])
      ..limit(limit, offset: offset);

    final rows = await query.get();

    return rows.map((row) {
      return MistakeDetail(
        record: row.readTable(idiomEngagementRecords),
        idiom: row.readTable(idioms),
      );
    }).toList();
  }

  /// 获取指定数量的失败过的成语ID (旧接口保留兼容)
  Future<List<int>> getFailedIdiomIds(int childId, {int limit = 5}) async {
    return getReviewQueue(childId, limit: limit);
  }
}