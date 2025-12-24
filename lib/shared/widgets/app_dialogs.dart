import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/theme/app_dimens.dart';
import 'package:children_rewards/l10n/app_localizations.dart';

class AppDialogs {
  static Future<T?> _showCustomDialog<T>({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required Color iconBorderColor,
    required String title,
    String? message,
    required String primaryButtonText,
    required Color primaryButtonColor,
    String? secondaryButtonText,
    bool isDestructive = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingL),
        child: _AnimatedDialogContent<T>(
          icon: icon,
          iconColor: iconColor,
          iconBgColor: iconBgColor,
          iconBorderColor: iconBorderColor,
          title: title,
          message: message,
          primaryButtonText: primaryButtonText,
          primaryButtonColor: primaryButtonColor,
          secondaryButtonText: secondaryButtonText,
          isDestructive: isDestructive,
        ),
      ),
    );
  }

  /// 错误弹窗
  static Future<void> showError(BuildContext context, String message) {
    final l10n = AppLocalizations.of(context)!;
    return _showCustomDialog<void>(
      context: context,
      icon: Icons.priority_high_rounded,
      iconColor: const Color(0xFFDC2626),
      iconBgColor: const Color(0xFFFEF2F2),
      iconBorderColor: const Color(0xFFFEE2E2),
      title: message,
      primaryButtonText: l10n.gotIt,
      primaryButtonColor: const Color(0xFFDC2626), // Matched to Icon Color
    );
  }

  /// 成功弹窗
  static Future<void> showSuccess(BuildContext context, String message) {
    final l10n = AppLocalizations.of(context)!;
    return _showCustomDialog<void>(
      context: context,
      icon: Icons.check_circle_rounded,
      iconColor: const Color(0xFF16A34A),
      iconBgColor: const Color(0xFFF0FDF4),
      iconBorderColor: const Color(0xFFDCFCE7),
      title: message,
      primaryButtonText: l10n.gotIt,
      primaryButtonColor: const Color(0xFF16A34A),
    );
  }

  /// 确认弹窗
  static Future<bool> showConfirm({
    required BuildContext context,
    required String title,
    String? message,
    String? confirmText,
    bool isDanger = false,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await _showCustomDialog<bool>(
      context: context,
      icon: isDanger ? Icons.warning_amber_rounded : Icons.help_outline_rounded,
      iconColor: isDanger ? const Color(0xFFDC2626) : const Color(0xFFD97706),
      iconBgColor: isDanger ? const Color(0xFFFEF2F2) : const Color(0xFFFEF3C7),
      iconBorderColor: isDanger ? const Color(0xFFFEE2E2) : const Color(0xFFFDE68A),
      title: title,
      message: message,
      primaryButtonText: confirmText ?? l10n.confirm,
      primaryButtonColor: isDanger ? const Color(0xFFDC2626) : AppColors.primary,
      secondaryButtonText: l10n.cancel,
      isDestructive: isDanger,
    );
    return result ?? false;
  }

  /// 删除确认弹窗
  static Future<bool> showDeleteConfirm({
    required BuildContext context,
    required String title,
    String? message,
    String? confirmText,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await _showCustomDialog<bool>(
      context: context,
      icon: Icons.delete_forever_rounded,
      iconColor: const Color(0xFFDC2626),
      iconBgColor: const Color(0xFFFEF2F2),
      iconBorderColor: const Color(0xFFFEE2E2),
      title: title,
      message: message,
      primaryButtonText: confirmText ?? l10n.delete,
      primaryButtonColor: const Color(0xFFDC2626),
      secondaryButtonText: l10n.cancel,
      isDestructive: true,
    );
    return result ?? false;
  }
}

/// The stateful widget that contains the dialog UI and animations.
class _AnimatedDialogContent<T> extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final Color iconBorderColor;
  final String title;
  final String? message;
  final String primaryButtonText;
  final Color primaryButtonColor;
  final String? secondaryButtonText;
  final bool isDestructive;

  const _AnimatedDialogContent({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.iconBorderColor,
    required this.title,
    this.message,
    required this.primaryButtonText,
    required this.primaryButtonColor,
    this.secondaryButtonText,
    this.isDestructive = false,
  });

  @override
  State<_AnimatedDialogContent<T>> createState() => _AnimatedDialogContentState<T>();
}

class _AnimatedDialogContentState<T> extends State<_AnimatedDialogContent<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.paddingL),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.radiusXL),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated Icon
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: _buildIcon(),
                );
              },
            ),

            const SizedBox(height: AppDimens.paddingL),

            // Title
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: AppColors.textMain,
                height: 1.2,
              ),
            ),

            // Message
            if (widget.message != null) ...[
              const SizedBox(height: AppDimens.paddingS),
              Text(
                widget.message!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ],
            const SizedBox(height: AppDimens.paddingXL),

            // Buttons
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: widget.iconBgColor,
        shape: BoxShape.circle,
        border: Border.all(color: widget.iconBorderColor, width: 4),
      ),
      child: Icon(widget.icon, color: widget.iconColor, size: 40),
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (widget.secondaryButtonText != null) {
      return Row(
        children: [
          // Secondary Button
          Expanded(
            child: SizedBox(
              height: 56,
              child: TextButton(
                onPressed: () => Navigator.pop(context, false),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F5F9),
                  foregroundColor: AppColors.textSecondary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusXL)),
                ),
                child: Text(
                  widget.secondaryButtonText!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppDimens.paddingM),
          // Primary Button
          Expanded(
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.primaryButtonColor,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: widget.primaryButtonColor.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusXL)),
                ),
                child: Text(
                  widget.primaryButtonText,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      // Single Button
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.primaryButtonColor,
            foregroundColor: Colors.white,
            elevation: 4,
            shadowColor: widget.primaryButtonColor.withValues(alpha: 0.3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusXL)),
          ),
          child: Text(
            widget.primaryButtonText,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
