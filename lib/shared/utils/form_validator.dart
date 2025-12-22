import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';

/// 统一的表单校验工具类
class FormValidator {
  /// 显示统一样式的错误提示
  static void showError(BuildContext context, String message) {
    AppDialogs.showError(context, message);
  }

  /// 校验必填字符串
  static bool validateRequired(
    BuildContext context,
    String? value,
    String errorMessage,
  ) {
    if (value == null || value.trim().isEmpty) {
      showError(context, errorMessage);
      return false;
    }
    return true;
  }

  /// 校验数字必须大于0
  static bool validatePositiveNumber(
    BuildContext context,
    String? value,
    AppLocalizations l10n,
  ) {
    final num = int.tryParse(value ?? '') ?? 0;
    if (num <= 0) {
      showError(context, l10n.numberMustBePositive);
      return false;
    }
    return true;
  }

  /// 校验数字必须大于等于0
  static bool validateNonNegativeNumber(
    BuildContext context,
    String? value,
    AppLocalizations l10n,
  ) {
    final num = int.tryParse(value ?? '');
    if (num == null || num < 0) {
      showError(context, l10n.invalidNumber);
      return false;
    }
    return true;
  }
}
