import 'dart:math';
import 'package:children_rewards/core/database/app_database.dart' as db;
import 'package:children_rewards/features/idiom_game/data/dao/idiom_dao.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart' as domain;
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_puzzle_entities.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_engagement_dao.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_puzzle_records_dao.dart';
import 'package:children_rewards/features/idiom_game/domain/services/idiom_puzzle_service.dart';
import 'package:children_rewards/features/idiom_game/utils/pinyin_utils.dart';

class IdiomPuzzleServiceImpl implements IdiomPuzzleService {
  final IdiomDao _idiomDao;
  final IdiomEngagementDao _engagementDao;
  final IdiomPuzzleRecordsDao _puzzleRecordsDao;
  final Random _random = Random();

  IdiomPuzzleServiceImpl(this._idiomDao, this._engagementDao, this._puzzleRecordsDao);

  @override
  Future<List<CompletionPuzzle>> generateCompletionPuzzles({
    required int grade,
    required int count,
    required int hiddenCount,
    required int childId,
    bool isReviewMode = false,
  }) async {
    // 1. Determine how many review items we need
    final int reviewLimit = isReviewMode ? count : (count * 0.3).ceil();
    
    // 2. Fetch review items from Mistake Book
    final reviewIds = await _engagementDao.getReviewQueue(childId, limit: reviewLimit);
    
    List<int> targetIds = [...reviewIds];
    
    // 3. If not review mode, or if we need to fill up to count (optional, but usually games are fixed length)
    // Design decision: In Review Mode, if we have fewer mistakes than count, we just play those.
    // In Normal Mode, we MUST fill up to `count`.
    if (!isReviewMode) {
      final remainingCount = count - targetIds.length;
      if (remainingCount > 0) {
        final allIds = await _idiomDao.getIdiomIdsByGrade(grade);
        allIds.shuffle(_random);
        
        final newIds = allIds
            .where((id) => !targetIds.contains(id))
            .take(remainingCount)
            .toList();
        targetIds.addAll(newIds);
      }
    }

    if (targetIds.isEmpty) return [];

    targetIds.shuffle(_random);

    final driftIdioms = await _idiomDao.getIdiomsByIds(targetIds);

    return driftIdioms.map((driftIdiom) {
      final domainIdiom = _toDomain(driftIdiom);
      return _createCompletionPuzzle(domainIdiom, hiddenCount);
    }).toList();
  }

  CompletionPuzzle _createCompletionPuzzle(domain.Idiom idiom, int hiddenCount) {
    final word = idiom.word;
    final length = word.length;
    final validIndices = List.generate(length, (i) => i);
    
    validIndices.shuffle(_random);
    final hiddenIndices = validIndices.take(hiddenCount).toList()..sort();
    
    final buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      if (hiddenIndices.contains(i)) {
        buffer.write('__');
      } else {
        buffer.write(word[i]);
      }
    }

    final correctOptions = hiddenIndices.map((i) {
      final char = word[i];
      final pinyins = idiom.pinyin.split(' ');
      final pinyin = (i < pinyins.length) ? pinyins[i] : '';
      return WordBankOption(char: char, pinyin: pinyin);
    }).toList();

    final distractorChars = _generateDistractorChars(8 - correctOptions.length, correctOptions.map((e) => e.char).toList());
    final distractorOptions = distractorChars.map((char) {
      return WordBankOption(char: char, pinyin: PinyinUtils.toPinyinWithTone(char));
    }).toList();
    
    final wordBank = [...correctOptions, ...distractorOptions];
    wordBank.shuffle(_random);

    return CompletionPuzzle(
      idiom: idiom,
      maskedWord: buffer.toString(),
      hiddenIndices: hiddenIndices,
      wordBank: wordBank,
    );
  }

  List<String> _generateDistractorChars(int count, List<String> exclude) {
    const commonChars = '一二三四五六七八九十百千万天地人日月星风云雷电山水火木金土东南西北前后左右上下大小多少';
    final available = commonChars.split('').where((c) => !exclude.contains(c)).toList();
    final actualCount = min(count, available.length);
    available.shuffle(_random);
    return available.take(actualCount).toList();
  }

  @override
  Future<List<MeaningPuzzle>> generateMeaningPuzzles({
    required int grade,
    required int count,
    int optionCount = 4,
    int? childId,
    bool isReviewMode = false,
  }) async {
    List<db.Idiom> targets = [];
    
    // 1. Fetch review items if childId is provided
    if (childId != null) {
      final int reviewLimit = isReviewMode ? count : (count * 0.3).ceil();
      final reviewIds = await _engagementDao.getReviewQueue(childId, limit: reviewLimit);
      
      if (reviewIds.isNotEmpty) {
        final reviewIdioms = await _idiomDao.getIdiomsByIds(reviewIds);
        // Only keep those with explanations
        targets.addAll(reviewIdioms.where((i) => i.explanation != null));
      }
    }
    
    // 2. Fill with new items
    if (!isReviewMode) {
       final remainingCount = count - targets.length;
       if (remainingCount > 0) {
          final candidates = await _idiomDao.getIdiomsWithExplanation(grade, count * 3);
          candidates.shuffle(_random);
          
          final newItems = candidates
              .where((c) => !targets.any((t) => t.id == c.id))
              .take(remainingCount)
              .toList();
          targets.addAll(newItems);
       }
    }

    if (targets.isEmpty) return [];

    targets.shuffle(_random);
    
    final puzzles = <MeaningPuzzle>[];
    
    // We need a pool for distractors.
    // For efficiency, we can use the same `candidates` list if we fetched it, 
    // or fetch a batch of random idioms.
    final distractorPool = await _idiomDao.getIdiomsWithExplanation(grade, count * 5); // Fetch enough
    
    for (final target in targets) {
      final pool = distractorPool.where((i) => i.id != target.id).toList();
      pool.shuffle(_random);
      final distractors = pool.take(optionCount - 1).toList();
      
      // Ensure we have enough options, otherwise might need to fetch more or relax constraints
      if (distractors.length < optionCount - 1) {
         // Fallback: just use what we have
      }

      final options = [target, ...distractors];
      options.shuffle(_random);
      
      puzzles.add(MeaningPuzzle(
        correctIdiom: _toDomain(target),
        explanation: target.explanation ?? '暂无释义',
        options: options.map((e) => IdiomOption(word: e.word, pinyin: e.pinyin)).toList(),
        correctIndex: options.indexOf(target),
      ));
    }
    
    return puzzles;
  }

  @override
  Future<PuzzleResult> validateCompletionAnswer(String answer, domain.Idiom target, int timeTaken) async {
    final cleanAnswer = answer.replaceAll(' ', '').replaceAll('_', '');
    final isCorrect = cleanAnswer == target.word;
    
    return PuzzleResult(
      isCorrect: isCorrect,
      timeTaken: timeTaken,
      playerInput: answer,
    );
  }

  @override
  PuzzleResult validateMeaningAnswer(int selectedIndex, MeaningPuzzle puzzle, int timeTaken) {
    return PuzzleResult(
      isCorrect: selectedIndex == puzzle.correctIndex,
      timeTaken: timeTaken,
      selectedIndex: selectedIndex,
    );
  }

  @override
  int calculateStars({
    required int correctCount,
    required int totalCount,
    required int hintsUsed,
    required int skippedCount,
    required int avgTimeSeconds,
    required int grade,
  }) {
    if (totalCount == 0) return 0;
    
    final double accuracy = correctCount / totalCount;
    int stars = 0;

    // Rule 1: Perfect Score (3 Stars)
    // 100% Accuracy AND No Skips AND Minimal Hints (optional, but requested logic focused on skips)
    if (correctCount == totalCount && skippedCount == 0) {
      stars = 3;
    } 
    // Rule 2: Mastery (2 Stars)
    // > 80% Accuracy AND < 2 Skips
    else if (accuracy >= 0.8 && skippedCount < 2) {
      stars = 2;
    }
    // Rule 3: Pass (1 Star)
    // > 60% Accuracy
    else if (accuracy >= 0.6) {
      stars = 1;
    }

    return stars;
  }

  @override
  Future<void> saveRecord({
    required int childId,
    required IdiomGameMode mode,
    required int grade,
    required int correctCount,
    required int totalCount,
    required int starsEarned,
    required int timeTakenSeconds,
  }) async {
    await _puzzleRecordsDao.saveRecord(
      childId: childId,
      mode: mode,
      grade: grade,
      correctCount: correctCount,
      totalCount: totalCount,
      starsEarned: starsEarned,
      timeTakenSeconds: timeTakenSeconds,
    );
  }

  @override
  Future<int> checkDataHealth(int grade, {bool requireExplanation = false}) {
    return _idiomDao.countAvailableIdioms(grade, requireExplanation: requireExplanation);
  }

  @override
  Future<db.IdiomEngagementRecord?> getEngagementRecord(int childId, int idiomId) {
    return _engagementDao.getEngagement(childId, idiomId);
  }

  @override
  Future<void> recordEngagement(int childId, int idiomId, {required bool isCorrect}) {
    return _engagementDao.upsertEngagement(childId, idiomId, isCorrect: isCorrect);
  }

  // Mapper
  domain.Idiom _toDomain(db.Idiom source) {
    return domain.Idiom(
      id: source.id,
      word: source.word,
      pinyin: source.pinyin,
      firstPinyinNoTone: source.firstPinyinNoTone,
      lastPinyinNoTone: source.lastPinyinNoTone,
      firstChar: source.firstChar,
      lastChar: source.lastChar,
      explanation: source.explanation,
      source: source.source,
    );
  }
}
