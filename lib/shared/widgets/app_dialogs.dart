import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    bool animate = false, // Animation control
  }) {
    return showDialog<T>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
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
          animate: animate,
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
      primaryButtonColor: AppColors.primary,
    );
  }

  /// 成功弹窗 (Optimized Style)
  static Future<void> showSuccess(BuildContext context, String message) {
    final l10n = AppLocalizations.of(context)!;
    return _showCustomDialog<void>(
      context: context,
      icon: Icons.check_circle_rounded, // Changed to checkmark icon
      iconColor: const Color(0xFF16A34A),      // Vibrant Green
      iconBgColor: const Color(0xFFF0FDF4),      // Light Green
      iconBorderColor: const Color(0xFFDCFCE7), // Lighter Green
      title: message,
      primaryButtonText: l10n.gotIt,
      primaryButtonColor: const Color(0xFF16A34A), // Primary button matches icon color
      animate: false, // Animation disabled for consistency
    );
  }

  /// 确认弹窗
  static Future<bool> showConfirm({
    required BuildContext context,
    required String title,
    String? message,
    String? confirmText,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await _showCustomDialog<bool>(
      context: context,
      icon: Icons.help_outline_rounded,
      iconColor: const Color(0xFFD97706),
      iconBgColor: const Color(0xFFFEF3C7),
      iconBorderColor: const Color(0xFFFDE68A),
      title: title,
      message: message,
      primaryButtonText: confirmText ?? l10n.confirm,
      primaryButtonColor: AppColors.primary,
      secondaryButtonText: l10n.cancel,
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
  final bool animate;

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
    this.animate = false,
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
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    if (widget.animate) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400), // Enlarged dialog
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xFFFFFEF9)],
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Icon
              if (widget.animate)
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildIcon(),
                )
              else
                _buildIcon(),

              const SizedBox(height: 20),

              // Title
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textMain,
                  height: 1.3,
                ),
              ),

              // Message
              if (widget.message != null) ...[
                const SizedBox(height: 10),
                Text(
                  widget.message!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary.withOpacity(0.8),
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const SizedBox(height: 32),

              // Buttons
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: widget.iconBgColor,
        shape: BoxShape.circle,
        border: Border.all(color: widget.iconBorderColor, width: 4),
      ),
      child: Icon(widget.icon, color: widget.iconColor, size: 28),
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (widget.secondaryButtonText != null) {
      return Row(
        children: [
          // Secondary Button
          Expanded(
            child: SizedBox(
              height: 40, // Shrink button height
              child: TextButton(
                onPressed: () => Navigator.pop(context, false),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F5F9),
                  foregroundColor: AppColors.textSecondary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  widget.secondaryButtonText!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Primary Button
          Expanded(
            child: SizedBox(
              height: 40, // Shrink button height
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.primaryButtonColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  widget.primaryButtonText,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      // Single Button
      return SizedBox(
        width: double.infinity, // Make single button fill width
        height: 40, // Shrink button height
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.primaryButtonColor,
            foregroundColor: Colors.white,
            elevation: 2,
            shadowColor: widget.primaryButtonColor.withOpacity(0.3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: Text(
            widget.primaryButtonText,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
          ),
        ),
      );
    }
  }
}