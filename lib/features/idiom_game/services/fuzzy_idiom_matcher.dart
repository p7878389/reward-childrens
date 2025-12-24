import 'package:children_rewards/core/database/app_database.dart' as db;
import 'package:children_rewards/core/logging/app_logger.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_dao.dart';
import 'package:children_rewards/features/idiom_game/utils/pinyin_utils.dart';

/// 成语模糊匹配结果
class FuzzyMatchResult {
  final db.Idiom? idiom; // 匹配到的成语
  final double confidence; // 匹配置信度 (0-1)
  final String matchType; // 匹配类型：exact/pinyin_exact/pinyin_fuzzy
  final String? originalInput; // 原始输入

  FuzzyMatchResult({
    this.idiom,
    required this.confidence,
    required this.matchType,
    this.originalInput,
  });

  bool get isMatch => idiom != null && confidence >= 0.7;
}

/// 成语模糊匹配器
/// 用于处理语音识别结果的模糊匹配，提高识别容错率
class FuzzyIdiomMatcher {
  static const String _tag = 'FuzzyMatcher';
  final IdiomDao _idiomDao;

  FuzzyIdiomMatcher(this._idiomDao);

  /// 模糊查找成语
  /// 按优先级尝试：精确匹配 → 拼音精确匹配 → 拼音相似度匹配
  ///
  /// [recognizedText] 语音识别的文本结果
  /// [minSimilarity] 最小相似度阈值
  Future<FuzzyMatchResult> fuzzyFind(String recognizedText, {double minSimilarity = 0.75}) async {
    final text = recognizedText.trim();
    logger.info(_tag, '开始模糊匹配: "$text"');

    if (text.isEmpty) {
      return FuzzyMatchResult(confidence: 0, matchType: 'empty');
    }

    // 1. 精确匹配（优先级最高）
    final exactMatch = await _idiomDao.findByWord(text);
    if (exactMatch != null) {
      logger.info(_tag, '精确匹配成功: "${exactMatch.word}"');
      return FuzzyMatchResult(
        idiom: exactMatch,
        confidence: 1.0,
        matchType: 'exact',
        originalInput: text,
      );
    }

    // 2. 拼音精确匹配（无声调）
    final inputPinyin = PinyinUtils.toPinyinNoTone(text);
    logger.info(_tag, '尝试拼音匹配: "$inputPinyin"');

    final pinyinExactMatch = await _idiomDao.findByExactPinyin(inputPinyin);
    if (pinyinExactMatch != null) {
      logger.info(_tag, '拼音精确匹配成功: "${pinyinExactMatch.word}"');
      return FuzzyMatchResult(
        idiom: pinyinExactMatch,
        confidence: 0.95,
        matchType: 'pinyin_exact',
        originalInput: text,
      );
    }

    // 3. 拼音相似度匹配
    final similarMatches = await _idiomDao.findBySimilarPinyin(
      inputPinyin,
      minSimilarity: minSimilarity,
      limit: 3,
    );

    if (similarMatches.isNotEmpty) {
      final bestMatch = similarMatches.first;
      logger.info(
        _tag,
        '拼音相似匹配: "${bestMatch.key.word}" (相似度: ${bestMatch.value.toStringAsFixed(2)})',
      );
      return FuzzyMatchResult(
        idiom: bestMatch.key,
        confidence: bestMatch.value,
        matchType: 'pinyin_fuzzy',
        originalInput: text,
      );
    }

    // 4. 未找到匹配
    logger.warning(_tag, '未找到匹配: "$text"');
    return FuzzyMatchResult(
      confidence: 0,
      matchType: 'not_found',
      originalInput: text,
    );
  }

  /// 检查识别结果是否可能是成语（基于长度）
  bool isPossibleIdiom(String text) {
    // 成语通常是4个字，这里放宽到 3-6 个字
    final chars = text.replaceAll(RegExp(r'\s+'), '');
    return chars.length >= 3 && chars.length <= 6;
  }
}

