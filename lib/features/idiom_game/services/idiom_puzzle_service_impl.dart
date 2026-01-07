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
        
        // Exclude engaged items to find "truly new" items
        final engagedIds = await _engagementDao.getAllEngagedIdiomIds(childId);
        final engagedSet = engagedIds.toSet();
        
        final trulyNewIds = allIds.where((id) => !engagedSet.contains(id)).toList();
        trulyNewIds.shuffle(_random);
        
        final selectedNewIds = trulyNewIds.take(remainingCount).toList();
        
        // If not enough new items, fill with "seen" items (that are not in current review list)
        if (selectedNewIds.length < remainingCount) {
          final needed = remainingCount - selectedNewIds.length;
          final seenAvailable = allIds.where((id) => engagedSet.contains(id) && !targetIds.contains(id)).toList();
          seenAvailable.shuffle(_random);
          selectedNewIds.addAll(seenAvailable.take(needed));
        }
        
        targetIds.addAll(selectedNewIds);
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
    List<int> targetIds = [];
    
    // 1. Fetch review items if childId is provided
    if (childId != null) {
      final int reviewLimit = isReviewMode ? count : (count * 0.3).ceil();
      final reviewIds = await _engagementDao.getReviewQueue(childId, limit: reviewLimit);
      targetIds.addAll(reviewIds);
    }
    
    // 2. Fill with new items
    if (!isReviewMode) {
       final remainingCount = count - targetIds.length;
       if (remainingCount > 0) {
          final allIds = await _idiomDao.getIdiomIdsWithExplanationByGrade(grade);
          
          Set<int> engagedSet = {};
          if (childId != null) {
            final engagedIds = await _engagementDao.getAllEngagedIdiomIds(childId);
            engagedSet = engagedIds.toSet();
          }
          
          final trulyNewIds = allIds.where((id) => !engagedSet.contains(id) && !targetIds.contains(id)).toList();
          trulyNewIds.shuffle(_random);
          
          final selectedNewIds = trulyNewIds.take(remainingCount).toList();
          
          if (selectedNewIds.length < remainingCount) {
             final needed = remainingCount - selectedNewIds.length;
             final seenAvailable = allIds.where((id) => engagedSet.contains(id) && !targetIds.contains(id)).toList();
             seenAvailable.shuffle(_random);
             selectedNewIds.addAll(seenAvailable.take(needed));
          }
          
          targetIds.addAll(selectedNewIds);
       }
    }

    if (targetIds.isEmpty) return [];

    // Load objects and filter valid ones
    final driftIdioms = await _idiomDao.getIdiomsByIds(targetIds);
    final targets = driftIdioms.where((i) => i.explanation != null && i.explanation!.length > 5).toList();
    
    if (targets.isEmpty) return [];

    targets.shuffle(_random);
    
    // Distractor Pool
    // To ensure variety, we fetch a larger pool of idioms with explanations
    final distractorPoolIds = await _idiomDao.getIdiomIdsWithExplanationByGrade(grade);
    distractorPoolIds.shuffle(_random);
    final distractorIds = distractorPoolIds.take(count * optionCount).toList();
    final distractorIdioms = await _idiomDao.getIdiomsByIds(distractorIds);
    
    final puzzles = <MeaningPuzzle>[];
    
    for (final target in targets) {
      final pool = distractorIdioms.where((i) => i.id != target.id).toList();
      pool.shuffle(_random);
      final distractors = pool.take(optionCount - 1).toList();
      
      // If pool is too small (should rarely happen if database is healthy), fill with duplicates or fewer options
      if (distractors.length < optionCount - 1) {
         // Fallback: This case is edge, but we proceed with fewer options if needed
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
    int baseStars = 0;

    // Base Stars (Based on Accuracy)
    if (accuracy >= 1.0) {
      baseStars = 3;
    } else if (accuracy >= 0.8) {
      baseStars = 2;
    } else if (accuracy >= 0.6) {
      baseStars = 1;
    }

    // Grade Multiplier
    double multiplier = 1.0;
    if (grade >= 7) {
      multiplier = 2.0;
    } else if (grade >= 5) {
      multiplier = 1.5;
    } else if (grade >= 3) {
      multiplier = 1.2;
    }

    // Speed Bonus
    int speedBonus = 0;
    if (avgTimeSeconds < 5) {
      speedBonus = 1;
    }

    // Hint Penalty
    // Assuming hintsUsed is passed correctly (currently 0 from provider, but logic is here)
    double hintPenalty = hintsUsed * 0.5;

    // Final Calculation
    // Formula: (Base * Multiplier) + Speed - Penalty
    double total = (baseStars * multiplier) + speedBonus - hintPenalty;
    
    return max(0, total.round());
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
