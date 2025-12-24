import 'package:flutter/material.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';

class ChildCard extends StatelessWidget {
  final ChildrenData child;
  final VoidCallback? onTap;

  const ChildCard({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // 解析年龄
    String ageText = "";
    if (child.birthday != null) {
      try {
        final birthDate = DateTime.parse(child.birthday!);
        final age = DateTime.now().year - birthDate.year;
        ageText = "$age ${l10n.years.toLowerCase()}";
      } catch (e, stackTrace) {
        logError('解析生日失败', tag: 'ChildCard', error: e, stackTrace: stackTrace);
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.textMain.withValues(alpha: 0.05),
              offset: const Offset(0, 4),
              blurRadius: 16,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Background Gradient/Decoration
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        child.gender == 'boy' ? AppColors.blueTag.withValues(alpha: 0.05) : AppColors.overlayYellow.withValues(alpha: 0.05),
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: _buildLayout(context, l10n, ageText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLayout(BuildContext context, AppLocalizations l10n, String ageText) {
    final locale = Localizations.localeOf(context);
    final isEnglish = locale.languageCode == 'en';

    if (isEnglish) {
      return _buildHorizontalLayout(l10n, ageText);
    } else {
      return _buildVerticalLayout(l10n, ageText);
    }
  }

  Widget _buildVerticalLayout(AppLocalizations l10n, String ageText) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(),
        const SizedBox(height: 6),
        _buildName(),
        const SizedBox(height: 6),
        _buildTags(l10n, ageText),
      ],
    );
  }

  Widget _buildHorizontalLayout(AppLocalizations l10n, String ageText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left: Avatar
        _buildAvatar(size: 60),
        const SizedBox(width: 14),
        // Right: Name and Tags
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                child.name,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textMain,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6.0,
                runSpacing: 4.0,
                children: [
                  _buildInfoTag(
                    icon: child.gender == 'boy' ? Icons.male_rounded : Icons.female_rounded,
                    text: child.gender == 'boy' ? l10n.boy : l10n.girl,
                    color: child.gender == 'boy' ? Colors.blue : Colors.pink,
                    bgColor: child.gender == 'boy' ? const Color(0xFFEFF6FF) : const Color(0xFFFFF1F2),
                  ),
                  if (ageText.isNotEmpty)
                    _buildInfoTag(
                      icon: Icons.cake_rounded,
                      text: ageText,
                      color: AppColors.textSecondary,
                      bgColor: const Color(0xFFF1F5F9),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar({double size = 72}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Hero(
          tag: 'child_avatar_${child.id}',
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                )
              ],
            ),
            child: _buildAvatarContent(child, size: size),
          ),
        ),
        Positioned(
          bottom: -2,
          right: -6,
          child: StarBadge(
            count: child.stars,
            avatarSize: size,
          ),
        ),
      ],
    );
  }

  Widget _buildName() {
    return Text(
      child.name,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        color: AppColors.textMain,
      ),
    );
  }

  Widget _buildTags(AppLocalizations l10n, String ageText) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.center,
      children: [
        _buildInfoTag(
          icon: child.gender == 'boy' ? Icons.male_rounded : Icons.female_rounded,
          text: child.gender == 'boy' ? l10n.boy : l10n.girl,
          color: child.gender == 'boy' ? Colors.blue : Colors.pink,
          bgColor: child.gender == 'boy' ? const Color(0xFFEFF6FF) : const Color(0xFFFFF1F2),
        ),
        if (ageText.isNotEmpty)
          _buildInfoTag(
            icon: Icons.cake_rounded,
            text: ageText,
            color: AppColors.textSecondary,
            bgColor: const Color(0xFFF1F5F9),
          ),
      ],
    );
  }

  Widget _buildInfoTag({
    required IconData icon,
    required String text,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: color.withValues(alpha: 0.8),
                letterSpacing: 0.5,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarContent(ChildrenData child, {double size = 56}) {
    return AvatarImage(
      avatar: child.avatar,
      fallbackText: child.name,
      size: size,
    );
  }
}