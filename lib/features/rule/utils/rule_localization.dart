import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';

/// 通用的名称本地化方法（支持直接传入名称字符串）
/// 尝试匹配系统规则名称并返回本地化文本，匹配不到则返回原文
String localizeRuleName(String? name, AppLocalizations l10n) {
  if (name == null) return "";

  switch (name) {
    case 'Clean Bedroom':
      return l10n.ruleCleanBedroom;
    case 'Finish Homework':
      return l10n.ruleFinishHomework;
    case 'Wash Dishes':
      return l10n.ruleWashDishes;
    case 'Walk the Dog':
      return l10n.ruleWalkTheDog;
    case 'Practice Instrument':
      return l10n.rulePracticeInstrument;
    case 'Tantrum':
      return l10n.ruleTantrum;
    case 'Fighting':
      return l10n.ruleFighting;
    case 'Not Listening':
      return l10n.ruleNotListening;
    case 'Custom Reward':
      return l10n.ruleCustomReward;
    case 'Custom Penalty':
      return l10n.ruleCustomPenalty;
    case 'Exchange':
      return l10n.ruleExchange;
    default:
      return name;
  }
}

/// 获取规则对象的本地化名称
String getLocalizedRuleName(Rule rule, AppLocalizations l10n) {
  if (!rule.isSystem) {
    return rule.name;
  }
  return localizeRuleName(rule.name, l10n);
}
