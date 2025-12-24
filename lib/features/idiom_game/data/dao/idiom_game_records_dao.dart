import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';

/// 成语游戏记录数据访问对象
class IdiomGameRecordsDao {
  final AppDatabase _db;

  IdiomGameRecordsDao(this._db);

  /// 保存游戏记录
  Future<int> saveRecord({
    required int childId,
    required int grade,
    required int score,
    required int chainLength,
    required int duration,
    int hintsUsed = 0,
    int fastAnswerCount = 0,
    int rareIdiomCount = 0,
    int playerTurns = 0,
    int timeoutWarningCount = 0,
    bool isAiSurrender = false,
    int comboMax = 0,
    int starsEarned = 0,
    int starRating = 0,
    String? idiomChain,
  }) async {
    final now = DateTime.now();
    return _db.into(_db.idiomGameRecords).insert(
          IdiomGameRecordsCompanion.insert(
            childId: childId,
            grade: grade,
            score: score,
            chainLength: chainLength,
            duration: duration,
            hintsUsed: Value(hintsUsed),
            fastAnswerCount: Value(fastAnswerCount),
            rareIdiomCount: Value(rareIdiomCount),
            playerTurns: Value(playerTurns),
            timeoutWarningCount: Value(timeoutWarningCount),
            isAiSurrender: Value(isAiSurrender),
            comboMax: Value(comboMax),
            starsEarned: Value(starsEarned),
            starRating: Value(starRating),
            idiomChain: Value(idiomChain),
            playedAt: now,
            createdAt: now,
          ),
        );
  }

  /// 获取最高分记录
  Future<IdiomGameRecord?> getHighScore(int childId, int grade) async {
    return (_db.select(_db.idiomGameRecords)
          ..where((t) => t.childId.equals(childId))
          ..where((t) => t.grade.equals(grade))
          ..where((t) => t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.score)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// 获取最近游戏记录
  Future<List<IdiomGameRecord>> getRecentRecords(
    int childId, {
    int? grade,
    int limit = 10,
  }) async {
    var query = _db.select(_db.idiomGameRecords)
      ..where((t) => t.childId.equals(childId))
      ..where((t) => t.isDeleted.equals(false));

    if (grade != null) {
      query = query..where((t) => t.grade.equals(grade));
    }

    query = query
      ..orderBy([(t) => OrderingTerm.desc(t.playedAt)])
      ..limit(limit);

    return query.get();
  }

  /// 获取游戏统计
  Future<Map<String, dynamic>> getStatistics(int childId) async {
    final records = await (_db.select(_db.idiomGameRecords)
          ..where((t) => t.childId.equals(childId))
          ..where((t) => t.isDeleted.equals(false)))
        .get();

    if (records.isEmpty) {
      return {
        'totalGames': 0,
        'totalScore': 0,
        'totalChainLength': 0,
        'totalDuration': 0,
        'totalStarsEarned': 0,
        'averageScore': 0.0,
        'averageChainLength': 0.0,
        'maxScore': 0,
        'maxChainLength': 0,
        'maxCombo': 0,
      };
    }

    final totalGames = records.length;
    final totalScore = records.fold<int>(0, (sum, r) => sum + r.score);
    final totalChainLength = records.fold<int>(0, (sum, r) => sum + r.chainLength);
    final totalDuration = records.fold<int>(0, (sum, r) => sum + r.duration);
    final totalStarsEarned = records.fold<int>(0, (sum, r) => sum + r.starsEarned);
    final maxScore = records.map((r) => r.score).reduce((a, b) => a > b ? a : b);
    final maxChainLength = records.map((r) => r.chainLength).reduce((a, b) => a > b ? a : b);
    final maxCombo = records.map((r) => r.comboMax).reduce((a, b) => a > b ? a : b);

    return {
      'totalGames': totalGames,
      'totalScore': totalScore,
      'totalChainLength': totalChainLength,
      'totalDuration': totalDuration,
      'totalStarsEarned': totalStarsEarned,
      'averageScore': totalScore / totalGames,
      'averageChainLength': totalChainLength / totalGames,
      'maxScore': maxScore,
      'maxChainLength': maxChainLength,
      'maxCombo': maxCombo,
    };
  }

  /// 删除记录
  Future<void> deleteRecord(int recordId) async {
    await (_db.update(_db.idiomGameRecords)
          ..where((t) => t.id.equals(recordId)))
        .write(const IdiomGameRecordsCompanion(
      isDeleted: Value(true),
    ));
  }

  /// 清空孩子的所有游戏记录
  Future<void> clearRecords(int childId) async {
    await (_db.update(_db.idiomGameRecords)
          ..where((t) => t.childId.equals(childId)))
        .write(const IdiomGameRecordsCompanion(
      isDeleted: Value(true),
    ));
  }
}
