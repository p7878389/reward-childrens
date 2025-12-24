import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_puzzle_entities.dart';

/// 成语补全/猜意思游戏记录 DAO
class IdiomPuzzleRecordsDao {
  final AppDatabase _db;

  IdiomPuzzleRecordsDao(this._db);

  /// 保存游戏记录
  Future<int> saveRecord({
    required int childId,
    required IdiomGameMode mode,
    required int grade,
    required int correctCount,
    required int totalCount,
    required int starsEarned,
    required int timeTakenSeconds,
  }) {
    return _db.into(_db.idiomPuzzleRecords).insert(
          IdiomPuzzleRecordsCompanion.insert(
            childId: childId,
            gameMode: mode.name,
            grade: grade,
            correctCount: correctCount,
            totalCount: totalCount,
            starsEarned: starsEarned,
            timeTakenSeconds: timeTakenSeconds,
            playedAt: DateTime.now(),
            createdAt: DateTime.now(),
          ),
        );
  }

  /// 获取某年级的游戏统计
  Future<Map<String, dynamic>> getStatistics(int childId, int grade) async {
    final query = _db.select(_db.idiomPuzzleRecords)
      ..where((t) => t.childId.equals(childId))
      ..where((t) => t.grade.equals(grade))
      ..where((t) => t.isDeleted.equals(false));

    final records = await query.get();

    if (records.isEmpty) {
      return {
        'totalPlayed': 0,
        'totalStars': 0,
        'avgAccuracy': 0.0,
      };
    }

    final totalStars = records.fold<int>(0, (sum, r) => sum + r.starsEarned);
    final totalQuestions = records.fold<int>(0, (sum, r) => sum + r.totalCount);
    final totalCorrect = records.fold<int>(0, (sum, r) => sum + r.correctCount);
    
    return {
      'totalPlayed': records.length,
      'totalStars': totalStars,
      'avgAccuracy': totalQuestions > 0 ? totalCorrect / totalQuestions : 0.0,
    };
  }

  /// 获取最近的游戏记录
  Future<List<IdiomPuzzleRecord>> getRecentRecords(int childId, {int limit = 10}) {
    return (_db.select(_db.idiomPuzzleRecords)
          ..where((t) => t.childId.equals(childId))
          ..where((t) => t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.playedAt)])
          ..limit(limit))
        .get();
  }
}
