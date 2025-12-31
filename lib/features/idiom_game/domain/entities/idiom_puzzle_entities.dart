import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart';

/// 游戏模式枚举
enum IdiomGameMode {
  chain,      // 成语接龙
  completion, // 成语补全
  meaning,    // 看意思猜成语
}

/// 选字选项 (含拼音)
class WordBankOption {
  final String char;
  final String pinyin;

  WordBankOption({required this.char, required this.pinyin});
}

/// 成语选项 (含拼音)
class IdiomOption {
  final String word;
  final String pinyin;

  IdiomOption({required this.word, required this.pinyin});
}

/// 成语补全题目
class CompletionPuzzle {
  final Idiom idiom;
  final String maskedWord;       // "一__当__"
  final List<int> hiddenIndices; // [1, 3]
  final List<WordBankOption> wordBank; // 备选字库 (正确字 + 干扰字)，含拼音

  CompletionPuzzle({
    required this.idiom,
    required this.maskedWord,
    required this.hiddenIndices,
    required this.wordBank,
  });
}

/// 看意思猜成语题目（选择题）
class MeaningPuzzle {
  final Idiom correctIdiom;
  final String explanation;
  final List<IdiomOption> options; // 4个选项，含拼音
  final int correctIndex;        // 正确答案索引

  MeaningPuzzle({
    required this.correctIdiom,
    required this.explanation,
    required this.options,
    required this.correctIndex,
  });
}

/// 答题结果
class PuzzleResult {
  final bool isCorrect;
  final bool isSkipped;
  final int timeTaken;
  final int? selectedIndex;      // 选择题用
  final String? playerInput;     // 补全题用

  PuzzleResult({
    required this.isCorrect,
    required this.timeTaken,
    this.isSkipped = false,
    this.selectedIndex,
    this.playerInput,
  });
}
