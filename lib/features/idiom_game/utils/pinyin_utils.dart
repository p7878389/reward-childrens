import 'package:lpinyin/lpinyin.dart';

/// 拼音工具类 - 用于语音识别的模糊匹配
class PinyinUtils {
  /// 将中文文本转换为拼音（无声调，空格分隔）
  /// 例如："万事如意" -> "wan shi ru yi"
  static String toPinyinNoTone(String text) {
    return PinyinHelper.getPinyin(
      text,
      separator: ' ',
      format: PinyinFormat.WITHOUT_TONE,
    );
  }

  /// 将中文文本转换为拼音（带声调）
  static String toPinyinWithTone(String text) {
    return PinyinHelper.getPinyin(
      text,
      separator: ' ',
      format: PinyinFormat.WITH_TONE_MARK,
    );
  }

  /// 将中文文本转换为拼音首字母
  static String toFirstLetters(String text) {
    return PinyinHelper.getShortPinyin(text);
  }

  /// 应用模糊发音规则，返回正则表达式模式
  /// 处理常见发音混淆：n/l, zh/z, ch/c, sh/s, r/l, an/ang, en/eng, in/ing 等
  static String applyFuzzyRules(String pinyin) {
    return pinyin
        // 声母模糊
        .replaceAll(RegExp(r'\bn'), '(n|l)')
        .replaceAll(RegExp(r'\bl'), '(n|l)')
        .replaceAll('zh', '(zh|z|j)')
        .replaceAll('ch', '(ch|c|q)')
        .replaceAll('sh', '(sh|s|x)')
        .replaceAll(RegExp(r'\br'), '(r|l|y)')
        // 韵母模糊（后鼻音/前鼻音）
        .replaceAll('ang', '(ang|an)')
        .replaceAll(RegExp(r'an(?!g)'), '(an|ang)')
        .replaceAll('eng', '(eng|en)')
        .replaceAll(RegExp(r'en(?!g)'), '(en|eng)')
        .replaceAll('ing', '(ing|in)')
        .replaceAll(RegExp(r'in(?!g)'), '(in|ing)');
  }

  /// 计算两个拼音字符串的相似度（0-1）
  /// 基于编辑距离
  static double similarity(String pinyin1, String pinyin2) {
    if (pinyin1 == pinyin2) return 1.0;
    if (pinyin1.isEmpty || pinyin2.isEmpty) return 0.0;

    final distance = _levenshteinDistance(pinyin1, pinyin2);
    final maxLen = pinyin1.length > pinyin2.length ? pinyin1.length : pinyin2.length;
    return 1.0 - (distance / maxLen);
  }

  /// 移除拼音中的声调标记（带声调 -> 无声调）
  static String removeTones(String pinyinWithTone) {
    const toneMap = {
      'ā': 'a', 'á': 'a', 'ǎ': 'a', 'à': 'a',
      'ē': 'e', 'é': 'e', 'ě': 'e', 'è': 'e',
      'ī': 'i', 'í': 'i', 'ǐ': 'i', 'ì': 'i',
      'ō': 'o', 'ó': 'o', 'ǒ': 'o', 'ò': 'o',
      'ū': 'u', 'ú': 'u', 'ǔ': 'u', 'ù': 'u',
      'ǖ': 'v', 'ǘ': 'v', 'ǚ': 'v', 'ǜ': 'v', 'ü': 'v',
    };

    var result = pinyinWithTone;
    toneMap.forEach((tone, base) {
      result = result.replaceAll(tone, base);
    });
    return result;
  }

  /// 计算编辑距离
  static int _levenshteinDistance(String s1, String s2) {
    if (s1 == s2) return 0;
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    List<int> prev = List<int>.generate(s2.length + 1, (i) => i);
    List<int> curr = List<int>.filled(s2.length + 1, 0);

    for (int i = 1; i <= s1.length; i++) {
      curr[0] = i;
      for (int j = 1; j <= s2.length; j++) {
        int cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        curr[j] = [
          prev[j] + 1, // 删除
          curr[j - 1] + 1, // 插入
          prev[j - 1] + cost // 替换
        ].reduce((a, b) => a < b ? a : b);
      }
      final temp = prev;
      prev = curr;
      curr = temp;
    }
    return prev[s2.length];
  }
}

