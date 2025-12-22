import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app_dialogs.dart';

class SwipeAction {
  final IconData icon;
  final String? label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;
  final bool autoClose;

  const SwipeAction({
    required this.icon,
    this.label,
    required this.backgroundColor,
    this.foregroundColor = Colors.white,
    required this.onPressed,
    this.autoClose = true,
  });
}

class SwipeableCard extends StatelessWidget {
  final Widget child;
  final Key itemKey;
  final VoidCallback? onDelete;
  final List<SwipeAction>? actions;
  final double? extentRatio;
  final Color deleteColor;
  final BorderRadius? actionBorderRadius;
  final bool enabled;

  const SwipeableCard({
    super.key,
    required this.child,
    required this.itemKey,
    this.onDelete,
    this.actions,
    this.extentRatio,
    this.deleteColor = const Color(0xFFFEF2F2),
    this.actionBorderRadius,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    final l10n = AppLocalizations.of(context)!;
    final actionList = _buildActionList(context, l10n);

    if (actionList.isEmpty) return child;

    return Slidable(
      key: itemKey,
      endActionPane: ActionPane(
        motion: const DrawerMotion(), 
        extentRatio: 0.25 * actionList.length,
        children: actionList.map((action) => _buildSlidableAction(context, action)).toList(),
      ),
      child: child,
    );
  }

  List<SwipeAction> _buildActionList(BuildContext context, AppLocalizations l10n) {
    if (actions != null && actions!.isNotEmpty) return actions!;
    if (onDelete != null) {
      return [
        SwipeAction(
          icon: Icons.delete_rounded,
          backgroundColor: const Color(0xFFFEE2E2),
          foregroundColor: const Color(0xFFEF4444),
          onPressed: onDelete!,
        ),
      ];
    }
    return [];
  }

  Widget _buildSlidableAction(BuildContext context, SwipeAction action) {
    return CustomSlidableAction(
      onPressed: (context) {
        if (action.autoClose) Slidable.of(context)?.close();
        HapticFeedback.lightImpact();
        action.onPressed();
      },
      backgroundColor: Colors.transparent, 
      foregroundColor: action.foregroundColor,
      padding: const EdgeInsets.only(left: 12),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: action.backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(action.icon, size: 28, color: action.foregroundColor),
          ],
        ),
      ),
    );
  }
}

class SwipeDeleteHelper {
  static Future<bool> showDeleteConfirmDialog({
    required BuildContext context,
    String? title,
    String? message,
    required VoidCallback onConfirm,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    HapticFeedback.mediumImpact();

    final confirmed = await AppDialogs.showDeleteConfirm(
      context: context,
      title: title ?? l10n.deleteProfile,
      message: message ?? l10n.deleteUndone,
      confirmText: l10n.yesDelete,
    );

    if (confirmed) {
      onConfirm();
    }
    return confirmed;
  }
}