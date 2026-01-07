import 'dart:math';
import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart' show IdiomMatchMode;
import 'package:children_rewards/features/idiom_game/utils/pinyin_utils.dart';

/// 成语数据访问对象
/// 提供成语查询、匹配等数据库操作
class IdiomDao {
  final AppDatabase _db;
  final Random _random = Random();

  IdiomDao(this._db);

  String _normalizePinyinNoTone(String pinyin) {
    return pinyin
        .toLowerCase()
        .replaceAll('ü', 'v')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  /// 转义 LIKE 查询中的特殊字符，防止 SQL 注入
  String _escapeLikePattern(String input) {
    return input.replaceAll('%', r'\%').replaceAll('_', r'\_');
  }

  /// 根据首字拼音查找成语（同音匹配）
  /// [pinyin] 无声调拼音
  /// [gradeLevel] 年级限制（可选）
  /// [excludeWords] 排除的成语列表
  /// [limit] 返回数量限制
  Future<List<Idiom>> findByFirstPinyin(
    String pinyin, {
    int? gradeLevel,
    List<String>? excludeWords,
    int limit = 10,
  }) async {
    final escapedPinyin = _escapeLikePattern(pinyin);
    var query = _db.select(_db.idioms)
      ..where((t) => t.firstPinyinNoTone.like('%$escapedPinyin%'))
      ..where((t) => t.isDeleted.equals(false));

    if (gradeLevel != null) {
      query = query..where((t) => t.gradeLevel.isSmallerOrEqualValue(gradeLevel));
    }

    if (excludeWords != null && excludeWords.isNotEmpty) {
      query = query..where((t) => t.word.isNotIn(excludeWords));
    }

    query = query
      ..orderBy([(t) => OrderingTerm.desc(t.frequency)])
      ..limit(limit);

    return query.get();
  }

  /// 根据首字查找成语（同字匹配）
  /// [char] 首字
  /// [gradeLevel] 年级限制（可选）
  /// [excludeWords] 排除的成语列表
  /// [limit] 返回数量限制
  Future<List<Idiom>> findByFirstChar(
    String char, {
    int? gradeLevel,
    List<String>? excludeWords,
    int limit = 10,
  }) async {
    var query = _db.select(_db.idioms)
      ..where((t) => t.firstChar.equals(char))
      ..where((t) => t.isDeleted.equals(false));

    if (gradeLevel != null) {
      query = query..where((t) => t.gradeLevel.isSmallerOrEqualValue(gradeLevel));
    }

    if (excludeWords != null && excludeWords.isNotEmpty) {
      query = query..where((t) => t.word.isNotIn(excludeWords));
    }

    query = query
      ..orderBy([(t) => OrderingTerm.desc(t.frequency)])
      ..limit(limit);

    return query.get();
  }

  /// 根据年级获取成语列表
  Future<List<Idiom>> findByGrade(
    int gradeLevel, {
    int limit = 100,
    int offset = 0,
  }) async {
    return (_db.select(_db.idioms)
          ..where((t) => t.gradeLevel.equals(gradeLevel))
          ..where((t) => t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.frequency)])
          ..limit(limit, offset: offset))
        .get();
  }

  /// 获取随机成语（用于游戏开始）
  /// [maxGrade] 最大年级
  /// [excludeWords] 排除的成语
  Future<Idiom?> getRandomIdiom({
    int? maxGrade,
    List<String>? excludeWords,
  }) async {
    var query = _db.select(_db.idioms)..where((t) => t.isDeleted.equals(false));

    if (maxGrade != null) {
      query = query..where((t) => t.gradeLevel.isSmallerOrEqualValue(maxGrade));
    }

    if (excludeWords != null && excludeWords.isNotEmpty) {
      query = query..where((t) => t.word.isNotIn(excludeWords));
    }

    // 优先选择高频词
    query = query
      ..orderBy([(t) => OrderingTerm.desc(t.frequency)])
      ..limit(100);

    final candidates = await query.get();
    if (candidates.isEmpty) return null;

    // 从高频词中随机选择
    return candidates[_random.nextInt(candidates.length)];
  }

  /// 根据成语文字精确查找
  Future<Idiom?> findByWord(String word) async {
    return (_db.select(_db.idioms)
          ..where((t) => t.word.equals(word))
          ..where((t) => t.isDeleted.equals(false)))
        .getSingleOrNull();
  }

  /// 模糊搜索成语
  Future<List<Idiom>> searchIdioms(
    String keyword, {
    int limit = 20,
  }) async {
    final escaped = _escapeLikePattern(keyword);
    return (_db.select(_db.idioms)
          ..where((t) =>
              t.word.like('%$escaped%') |
              t.pinyin.like('%$escaped%') |
              t.explanation.like('%$escaped%'))
          ..where((t) => t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.frequency)])
          ..limit(limit))
        .get();
  }

  /// 获取成语总数
  Future<int> getCount({int? gradeLevel}) async {
    final query = _db.selectOnly(_db.idioms)
      ..addColumns([_db.idioms.id.count()])
      ..where(_db.idioms.isDeleted.equals(false));

    if (gradeLevel != null) {
      query.where(_db.idioms.gradeLevel.equals(gradeLevel));
    }

    final result = await query.getSingle();
    return result.read(_db.idioms.id.count()) ?? 0;
  }

  /// 检查成语是否可以接龙
  /// [previousIdiom] 上一个成语
  /// [currentWord] 当前输入的成语
  /// [useHomophone] 是否使用同音匹配
  Future<bool> canChain(
    Idiom previousIdiom,
    String currentWord, {
    bool useHomophone = true,
  }) async {
    final current = await findByWord(currentWord);
    if (current == null) return false;

    if (useHomophone) {
      // 同音匹配：上一个成语的尾字拼音 == 当前成语的首字拼音
      final prevLastPinyins = previousIdiom.lastPinyinNoTone.split(',');
      final currFirstPinyins = current.firstPinyinNoTone.split(',');

      for (final prevPinyin in prevLastPinyins) {
        for (final currPinyin in currFirstPinyins) {
          if (prevPinyin.trim() == currPinyin.trim()) {
            return true;
          }
        }
      }
      return false;
    } else {
      // 同字匹配：上一个成语的尾字 == 当前成语的首字
      return previousIdiom.lastChar == current.firstChar;
    }
  }

  /// 获取可接龙的成语列表（AI 使用）
  /// [previousIdiom] 上一个成语
  /// [useHomophone] 是否使用同音匹配
  /// [maxGrade] 最大年级
  /// [excludeWords] 排除的成语
  /// [limit] 返回数量
  Future<List<Idiom>> getChainableIdioms(
    Idiom previousIdiom, {
    bool useHomophone = true,
    int? maxGrade,
    List<String>? excludeWords,
    int limit = 10,
  }) async {
    if (useHomophone) {
      // 同音匹配 - 使用 IN 查询替代循环（修复 N+1 问题）
      final lastPinyins = previousIdiom.lastPinyinNoTone
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
      if (lastPinyins.isEmpty) {
        return findByFirstChar(previousIdiom.lastChar, gradeLevel: maxGrade, excludeWords: excludeWords, limit: limit);
      }

      var query = _db.select(_db.idioms)
        ..where((t) => t.firstPinyinNoTone.isIn(lastPinyins))
        ..where((t) => t.isDeleted.equals(false));

      if (maxGrade != null) {
        query = query..where((t) => t.gradeLevel.isSmallerOrEqualValue(maxGrade));
      }
      if (excludeWords != null && excludeWords.isNotEmpty) {
        query = query..where((t) => t.word.isNotIn(excludeWords));
      }

      query = query
        ..orderBy([(t) => OrderingTerm.desc(t.frequency)])
        ..limit(limit);

      return query.get();
    } else {
      // 同字匹配
      return findByFirstChar(
        previousIdiom.lastChar,
        gradeLevel: maxGrade,
        excludeWords: excludeWords,
        limit: limit,
      );
    }
  }

  /// 获取有释义的成语（用于"看意思猜成语"）
  /// [grade] 年级
  /// [limit] 数量限制
  Future<List<Idiom>> getIdiomsWithExplanation(int grade, int limit) async {
    return (_db.select(_db.idioms)
          ..where((t) => t.gradeLevel.equals(grade))
          ..where((t) => t.explanation.isNotNull())
          // 过滤掉释义太短的（可能是脏数据）
          ..where((t) => t.explanation.length.isBiggerThanValue(5))
          ..where((t) => t.isDeleted.equals(false))
          ..limit(limit))
        .get();
  }

  /// 获取某年级所有成语 ID (用于高性能随机)
  Future<List<int>> getIdiomIdsByGrade(int grade) async {
    final query = _db.selectOnly(_db.idioms)
      ..addColumns([_db.idioms.id])
      ..where(_db.idioms.gradeLevel.equals(grade))
      ..where(_db.idioms.isDeleted.equals(false));

    final result = await query.get();
    return result.map((row) => row.read(_db.idioms.id)!).toList();
  }

  /// 获取某年级所有带释义的成语 ID
  Future<List<int>> getIdiomIdsWithExplanationByGrade(int grade) async {
    final query = _db.selectOnly(_db.idioms)
      ..addColumns([_db.idioms.id])
      ..where(_db.idioms.gradeLevel.equals(grade))
      ..where(_db.idioms.explanation.isNotNull())
      ..where(_db.idioms.explanation.length.isBiggerThanValue(5))
      ..where(_db.idioms.isDeleted.equals(false));

    final result = await query.get();
    return result.map((row) => row.read(_db.idioms.id)!).toList();
  }

  /// 批量获取成语
  Future<List<Idiom>> getIdiomsByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    return (_db.select(_db.idioms)..where((t) => t.id.isIn(ids))).get();
  }

  /// 统计可用成语数量 (Health Check)
  Future<int> countAvailableIdioms(
      int grade, {
      bool requireExplanation = false,
      }) async {
    final query = _db.selectOnly(_db.idioms)
      ..addColumns([_db.idioms.id.count()])
      ..where(_db.idioms.gradeLevel.equals(grade))
      ..where(_db.idioms.isDeleted.equals(false));

    if (requireExplanation) {
      query.where(_db.idioms.explanation.isNotNull());
      query.where(_db.idioms.explanation.length.isBiggerThanValue(5));
    }

    final result = await query.getSingle();
    return result.read(_db.idioms.id.count()) ?? 0;
  }

  /// 获取可接龙的开局成语
  Future<Idiom?> getPlayableStartIdiom({
    required int grade,
    bool includeRare = false,
    List<String> preferredLastChars = const [],
    List<String> failedLastChars = const [],
    List<String> excludeWords = const [],
    int maxAttempts = 10,
  }) async {
    final preferred = preferredLastChars.isNotEmpty ? preferredLastChars : failedLastChars;

    Future<List<Idiom>> loadCandidates({required bool preferOnly}) async {
      var query = _db.select(_db.idioms)
        ..where((t) => t.gradeLevel.isSmallerOrEqualValue(grade))
        ..where((t) => t.isDeleted.equals(false));

      if (!includeRare) {
        query = query..where((t) => t.isRare.equals(false));
      }

      if (preferOnly && preferred.isNotEmpty) {
        query = query..where((t) => t.lastChar.isIn(preferred));
      }

      if (excludeWords.isNotEmpty) {
        query = query..where((t) => t.word.isNotIn(excludeWords));
      }

      query = query
        ..orderBy([(t) => OrderingTerm.desc(t.frequency)])
        ..limit(200);

      return query.get();
    }

    final preferredCandidates = await loadCandidates(preferOnly: true);
    final candidates = preferredCandidates.isNotEmpty ? preferredCandidates : await loadCandidates(preferOnly: false);
    if (candidates.isEmpty) return null;

    final attempts = min(maxAttempts, candidates.length);
    final pool = List<Idiom>.of(candidates);

    for (var i = 0; i < attempts; i++) {
      final candidate = pool.removeAt(_random.nextInt(pool.length));

      final exact = await findNextIdioms(
        lastChar: candidate.lastChar,
        lastPinyin: candidate.lastPinyin,
        matchMode: IdiomMatchMode.exact,
        includeRare: includeRare,
        excludeWords: [candidate.word],
        limit: 1,
      );
      if (exact.isNotEmpty) return candidate;

      if (candidate.lastPinyin.isNotEmpty) {
        final homophone = await findNextIdioms(
          lastChar: candidate.lastChar,
          lastPinyin: candidate.lastPinyin,
          matchMode: IdiomMatchMode.homophone,
          includeRare: includeRare,
          excludeWords: [candidate.word],
          limit: 1,
        );
        if (homophone.isNotEmpty) return candidate;
      }
    }

    return candidates[_random.nextInt(candidates.length)];
  }

  /// 查找下一个可接龙的成语
  /// 优化：单次查询 + 应用层排序，避免多次数据库往返
  Future<List<Idiom>> findNextIdioms({
    required String lastChar,
    String? lastPinyin,
    required IdiomMatchMode matchMode,
    bool includeRare = false,
    List<String>? excludeWords,
    int limit = 10,
    List<String> preferredLastChars = const [],
    List<String> avoidLastChars = const [],
    int currentChainLength = 0,
  }) async {
    if (limit <= 0) return [];

    // 单次查询获取足够候选，应用层排序
    final fetchLimit = (preferredLastChars.isNotEmpty || avoidLastChars.isNotEmpty)
        ? max(limit * 3, 50)
        : limit;

    var query = _db.select(_db.idioms)..where((t) => t.isDeleted.equals(false));

    if (!includeRare) {
      query = query..where((t) => t.isRare.equals(false));
    }

    if (excludeWords != null && excludeWords.isNotEmpty) {
      query = query..where((t) => t.word.isNotIn(excludeWords));
    }

    switch (matchMode) {
      case IdiomMatchMode.exact:
        query = query..where((t) => t.firstChar.equals(lastChar));
        break;
      case IdiomMatchMode.contains:
        final escapedChar = _escapeLikePattern(lastChar);
        query = query..where((t) => t.word.like('%$escapedChar%'));
        break;
      case IdiomMatchMode.homophone:
        final pinyins = (lastPinyin ?? '')
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
        if (pinyins.isEmpty) {
          query = query..where((t) => t.firstChar.equals(lastChar));
        } else if (pinyins.length == 1) {
          query = query..where((t) => t.firstPinyin.equals(pinyins.first));
        } else {
          query = query..where((t) => t.firstPinyin.isIn(pinyins));
        }
        break;
    }

    query = query
      ..orderBy([(t) => OrderingTerm.desc(t.frequency)])
      ..limit(fetchLimit);

    final candidates = await query.get();
    if (candidates.isEmpty) return [];

    // 无需排序时直接返回
    if (preferredLastChars.isEmpty && avoidLastChars.isEmpty) {
      return candidates.take(limit).toList();
    }

    // 应用层按优先级排序：preferred > normal > avoid
    final preferredSet = preferredLastChars.toSet();
    final avoidSet = avoidLastChars.toSet();

    int priority(Idiom i) {
      if (preferredSet.contains(i.lastChar)) return 0; // 最高优先
      if (avoidSet.contains(i.lastChar)) return 2;     // 最低优先
      return 1;                                         // 中等优先
    }

    candidates.sort((a, b) {
      final pa = priority(a), pb = priority(b);
      if (pa != pb) return pa.compareTo(pb);
      return b.frequency.compareTo(a.frequency); // 同优先级按频率降序
    });

    return candidates.take(limit).toList();
  }

  /// 统计成语总数
  Future<int> count({bool includeRare = false}) async {
    final query = _db.selectOnly(_db.idioms)
      ..addColumns([_db.idioms.id.count()])
      ..where(_db.idioms.isDeleted.equals(false));
    if (!includeRare) {
      query.where(_db.idioms.isRare.equals(false));
    }
    final result = await query.getSingle();
    return result.read(_db.idioms.id.count()) ?? 0;
  }

  /// 检查是否存在可接龙的成语（使用 EXISTS 优化，只查 1 条）
  Future<bool> hasNextIdiom({
    required String lastChar,
    String? lastPinyin,
    required IdiomMatchMode matchMode,
    bool includeRare = false,
    List<String>? excludeWords,
  }) async {
    var query = _db.select(_db.idioms)..where((t) => t.isDeleted.equals(false));

    if (!includeRare) {
      query = query..where((t) => t.isRare.equals(false));
    }

    if (excludeWords != null && excludeWords.isNotEmpty) {
      query = query..where((t) => t.word.isNotIn(excludeWords));
    }

    switch (matchMode) {
      case IdiomMatchMode.exact:
        query = query..where((t) => t.firstChar.equals(lastChar));
        break;
      case IdiomMatchMode.contains:
        final escapedChar = _escapeLikePattern(lastChar);
        query = query..where((t) => t.word.like('%$escapedChar%'));
        break;
      case IdiomMatchMode.homophone:
        final pinyins = (lastPinyin ?? '')
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
        if (pinyins.isEmpty) {
          query = query..where((t) => t.firstChar.equals(lastChar));
        } else if (pinyins.length == 1) {
          query = query..where((t) => t.firstPinyin.equals(pinyins.first));
        } else {
          query = query..where((t) => t.firstPinyin.isIn(pinyins));
        }
        break;
    }

    query = query..limit(1);
    final result = await query.get();
    return result.isNotEmpty;
  }

  /// 根据拼音精确查找成语
  /// [pinyinNoTone] 无声调拼音（空格分隔），例如："yi ding bu shi"
  Future<Idiom?> findByExactPinyin(
    String pinyinNoTone, {
    bool includeRare = true,
    List<String>? excludeWords,
  }) async {
    final normalizedInput = _normalizePinyinNoTone(pinyinNoTone);
    if (normalizedInput.isEmpty) return null;

    final parts = normalizedInput.split(' ');
    final first = parts.isNotEmpty ? parts.first : '';
    final last = parts.isNotEmpty ? parts.last : '';

    var query = _db.select(_db.idioms)..where((t) => t.isDeleted.equals(false));
    if (!includeRare) {
      query = query..where((t) => t.isRare.equals(false));
    }
    if (excludeWords != null && excludeWords.isNotEmpty) {
      query = query..where((t) => t.word.isNotIn(excludeWords));
    }

    if (first.isNotEmpty) {
      final escapedFirst = _escapeLikePattern(first);
      query = query..where((t) => t.firstPinyinNoTone.like('%$escapedFirst%'));
    }
    if (last.isNotEmpty) {
      final escapedLast = _escapeLikePattern(last);
      query = query..where((t) => t.lastPinyinNoTone.like('%$escapedLast%'));
    }

    query = query
      ..orderBy([(t) => OrderingTerm.desc(t.frequency)])
      ..limit(100);

    final candidates = await query.get();
    for (final idiom in candidates) {
      final noTone = _normalizePinyinNoTone(PinyinUtils.removeTones(idiom.pinyin));
      if (noTone == normalizedInput) return idiom;
    }
    return null;
  }

  /// 根据拼音相似度查找成语
  Future<List<MapEntry<Idiom, double>>> findBySimilarPinyin(
    String inputPinyin, {
    double minSimilarity = 0.75,
    int limit = 3,
  }) async {
    final normalizedInput = _normalizePinyinNoTone(inputPinyin);
    if (normalizedInput.isEmpty || limit <= 0) return [];

    final parts = normalizedInput.split(' ');
    final first = parts.isNotEmpty ? parts.first : '';
    final last = parts.isNotEmpty ? parts.last : '';
    final candidateLimit = min(500, max(200, limit * 50));

    var query = _db.select(_db.idioms)
      ..where((t) => t.isDeleted.equals(false))
      ..orderBy([(t) => OrderingTerm.desc(t.frequency)])
      ..limit(candidateLimit);

    if (first.isNotEmpty || last.isNotEmpty) {
      final escapedFirst = _escapeLikePattern(first);
      final escapedLast = _escapeLikePattern(last);
      query = query
        ..where((t) =>
            (first.isEmpty ? const Constant(false) : t.firstPinyinNoTone.like('%$escapedFirst%')) |
            (last.isEmpty ? const Constant(false) : t.lastPinyinNoTone.like('%$escapedLast%')));
    }

    final candidates = await query.get();
    final results = <MapEntry<Idiom, double>>[];

    for (final idiom in candidates) {
      final noTone = _normalizePinyinNoTone(PinyinUtils.removeTones(idiom.pinyin));
      final similarity = PinyinUtils.similarity(normalizedInput, noTone);
      if (similarity >= minSimilarity) {
        results.add(MapEntry(idiom, similarity));
      }
    }

    results.sort((a, b) {
      final byScore = b.value.compareTo(a.value);
      if (byScore != 0) return byScore;
      return b.key.frequency.compareTo(a.key.frequency);
    });

    if (results.length <= limit) return results;
    return results.take(limit).toList();
  }
}
