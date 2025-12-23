import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/providers/locale_provider.dart';
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/features/settings/presentation/screens/privacy_policy_screen.dart';
import 'package:children_rewards/features/settings/presentation/screens/logs_screen.dart';
import 'package:children_rewards/features/rewards/presentation/screens/rewards_manage_screen.dart';
import 'package:children_rewards/features/rule/presentation/screens/rules_manage_screen.dart';
import 'package:children_rewards/features/badges/presentation/screens/badge_manage_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.1), spreadRadius: 1)],
                ),
                child: Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF6366F1), shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text(
                      l10n.settings.toUpperCase(),
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1.1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              _buildSectionHeader(l10n.language),
              _buildSettingTile(
                icon: Icons.language_rounded,
                title: "English / 中文",
                trailing: DropdownButton<String>(
                  value: currentLocale?.languageCode ?? 'system',
                  underline: const SizedBox(),
                  items: [
                    DropdownMenuItem(value: 'system', child: Text(l10n.systemDefault)),
                    const DropdownMenuItem(value: 'en', child: Text("English")),
                    const DropdownMenuItem(value: 'zh', child: Text("中文")),
                  ],
                  onChanged: (val) {
                    if (val == 'system') {
                      ref.read(localeProvider.notifier).state = null;
                    } else {
                      ref.read(localeProvider.notifier).state = Locale(val!);
                    }
                  },
                ),
              ),

              const SizedBox(height: 32),
              _buildSectionHeader(l10n.dataManagement),
              _buildSettingTile(
                icon: Icons.card_giftcard_rounded,
                title: l10n.manageRewards,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RewardsManageScreen()),
                  );
                },
              ),
              _buildSettingTile(
                icon: Icons.checklist_rounded,
                title: l10n.manageRules,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RulesManageScreen(showBackButton: true)),
                  );
                },
              ),
              _buildSettingTile(
                icon: Icons.shield_rounded,
                title: '徽章配置',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BadgeManageScreen()),
                  );
                },
              ),
              _buildSettingTile(
                icon: Icons.article_outlined,
                title: l10n.logs,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogsScreen()),
                  );
                },
              ),
              _buildSettingTile(
                icon: Icons.delete_forever_rounded,
                title: l10n.clearAllData,
                titleColor: Colors.red,
                onTap: () => _confirmClearData(context, ref, l10n),
              ),

              const SizedBox(height: 32),
              _buildSectionHeader(l10n.appTitle),
              _buildSettingTile(
                icon: Icons.info_outline_rounded,
                title: l10n.appVersion,
                trailing: const Text("1.0.0", style: TextStyle(color: AppColors.textSecondary)),
              ),
              _buildSettingTile(
                icon: Icons.description_outlined,
                title: l10n.privacyPolicy,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
                  );
                },
              ),
              const SizedBox(height: 100), // Bottom nav space
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8, top: 16),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1.0),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    Color? titleColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: AppColors.primary.withOpacity(0.05), spreadRadius: 1),
            BoxShadow(color: AppColors.textMain.withOpacity(0.02), offset: const Offset(0, 4), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: titleColor ?? AppColors.textSecondary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: titleColor ?? AppColors.textMain,
                ),
              ),
            ),
            if (trailing != null) trailing else Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary.withOpacity(0.3)),
          ],
        ),
      ),
    );
  }

  void _confirmClearData(BuildContext context, WidgetRef ref, AppLocalizations l10n) async {
    final confirmed = await AppDialogs.showDeleteConfirm(
      context: context,
      title: l10n.clearDataTitle,
      message: l10n.clearDataMessage,
      confirmText: l10n.deleteEverything,
    );

    if (confirmed) {
      try {
        // 执行清空数据
        await ref.read(databaseProvider).clearAllData();
        if (context.mounted) {
          AppDialogs.showSuccess(context, l10n.dataClearedSuccess);
        }
      } catch (e, stackTrace) {
        logError('清空数据失败', tag: 'SettingsScreen', error: e, stackTrace: stackTrace);
        if (context.mounted) {
          AppDialogs.showError(context, "Error: $e");
        }
      }
    }
  }
}
