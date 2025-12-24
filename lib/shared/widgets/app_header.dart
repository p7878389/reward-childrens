import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/theme/app_dimens.dart';
import 'package:children_rewards/shared/widgets/header_button.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final bool showBack;
  final Color? backgroundColor;
  final Widget? leading;
  final Color? dotColor;

  const AppHeader({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
    this.showBack = true,
    this.backgroundColor,
    this.leading,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 64.0,
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingL),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Leading or Back Button or Spacer
              SizedBox(
                width: 48, // Fixed width for alignment
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: leading ?? (showBack
                      ? HeaderButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onTap: onBack ?? () => Navigator.maybePop(context),
                        )
                      : const SizedBox.shrink()),
                ),
              ),

              // Center: Title Badge
              Expanded(
                child: Center(
                  child: Container(
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textMain.withValues(alpha: 0.05),
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: dotColor ?? AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            title.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textSecondary,
                              letterSpacing: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Right: Actions or Spacer
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 48),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: (actions != null && actions!.isNotEmpty)
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: actions!,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
