import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';

/// 年级进度数据访问对象
class IdiomGradeProgressDao {
  final AppDatabase _db;

  IdiomGradeProgressDao(this._db);

  /// 获取孩子的所有年级进度
  Future<List<IdiomGradeProgressData>> getAllProgress(int childId) async {
    return (_db.select(_db.idiomGradeProgress)
          ..where((t) => t.childId.equals(childId))
          ..where((t) => t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.grade)]))
        .get();
  }

  /// 获取指定年级的进度
  Future<IdiomGradeProgressData?> getProgress(int childId, int grade) async {
    return (_db.select(_db.idiomGradeProgress)
          ..where((t) => t.childId.equals(childId))
          ..where((t) => t.grade.equals(grade))
          ..where((t) => t.isDeleted.equals(false)))
        .getSingleOrNull();
  }

  /// 初始化孩子的年级进度（首次进入游戏时调用）
  Future<void> initializeProgress(int childId) async {
    final existing = await getAllProgress(childId);
    if (existing.isNotEmpty) return;

    final now = DateTime.now();
    await _db.batch((b) {
      for (int grade = 1; grade <= 12; grade++) {
        b.insert(
          _db.idiomGradeProgress,
          IdiomGradeProgressCompanion.insert(
            childId: childId,
            grade: grade,
            isUnlocked: Value(grade == 1), // 只有1年级默认解锁
            createdAt: now,
          ),
        );
      }
    });
  }

  /// 更新年级进度
  Future<void> updateProgress({
    required int childId,
    required int grade,
    int? highScore,
    int? bestChainLength,
    int? starRating,
    bool? isUnlocked,
  }) async {
    final existing = await getProgress(childId, grade);
    final now = DateTime.now();

    if (existing != null) {
      // 只更新更好的成绩
      final newHighScore = highScore != null && highScore > existing.highScore
          ? highScore
          : existing.highScore;
      final newBestChain = bestChainLength != null && bestChainLength > existing.bestChainLength
          ? bestChainLength
          : existing.bestChainLength;
      final newStarRating = starRating != null && starRating > existing.starRating
          ? starRating
          : existing.starRating;

      await (_db.update(_db.idiomGradeProgress)
            ..where((t) => t.id.equals(existing.id)))
          .write(IdiomGradeProgressCompanion(
        highScore: Value(newHighScore),
        bestChainLength: Value(newBestChain),
        starRating: Value(newStarRating),
        playCount: Value(existing.playCount + 1),
        isUnlocked: isUnlocked != null ? Value(isUnlocked) : const Value.absent(),
        updatedAt: Value(now),
      ));
    } else {
      // 创建新记录
      await _db.into(_db.idiomGradeProgress).insert(
            IdiomGradeProgressCompanion.insert(
              childId: childId,
              grade: grade,
              highScore: Value(highScore ?? 0),
              bestChainLength: Value(bestChainLength ?? 0),
              starRating: Value(starRating ?? 0),
              playCount: const Value(1),
              isUnlocked: Value(isUnlocked ?? false),
              createdAt: now,
            ),
          );
    }
  }

  /// 解锁下一年级
  Future<void> unlockNextGrade(int childId, int currentGrade) async {
    if (currentGrade >= 12) return;

    final nextGrade = currentGrade + 1;
    final existing = await getProgress(childId, nextGrade);

    if (existing != null && !existing.isUnlocked) {
      await (_db.update(_db.idiomGradeProgress)
            ..where((t) => t.id.equals(existing.id)))
          .write(IdiomGradeProgressCompanion(
        isUnlocked: const Value(true),
        updatedAt: Value(DateTime.now()),
      ));
    } else if (existing == null) {
      await _db.into(_db.idiomGradeProgress).insert(
            IdiomGradeProgressCompanion.insert(
              childId: childId,
              grade: nextGrade,
              isUnlocked: const Value(true),
              createdAt: DateTime.now(),
            ),
          );
    }
  }

  /// 检查年级是否解锁
  Future<bool> isGradeUnlocked(int childId, int grade) async {
    if (grade == 1) return true; // 1年级始终解锁

    final progress = await getProgress(childId, grade);
    return progress?.isUnlocked ?? false;
  }

  /// 获取当前最高解锁年级
  Future<int> getHighestUnlockedGrade(int childId) async {
    final progress = await getAllProgress(childId);
    if (progress.isEmpty) return 1;

    int highest = 1;
    for (final p in progress) {
      if (p.isUnlocked && p.grade > highest) {
        highest = p.grade;
      }
    }
    return highest;
  }

  /// 获取总星星数
  Future<int> getTotalStars(int childId) async {
    final progress = await getAllProgress(childId);
    return progress.fold<int>(0, (sum, p) => sum + p.starRating);
  }

  /// 重置所有进度
  Future<void> resetAllProgress(int childId) async {
    await (_db.update(_db.idiomGradeProgress)
          ..where((t) => t.childId.equals(childId)))
        .write(const IdiomGradeProgressCompanion(
      isDeleted: Value(true),
    ));

    // 重新初始化
    await initializeProgress(childId);
  }
}
