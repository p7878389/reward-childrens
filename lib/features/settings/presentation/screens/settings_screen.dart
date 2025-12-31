import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
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
import 'package:children_rewards/features/settings/presentation/screens/resource_download_screen.dart';
import 'package:children_rewards/core/services/database_backup_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);

    return Column(
      children: [
        AppHeader(
          title: l10n.settings,
          showBack: false,
          dotColor: const Color(0xFF6366F1),
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
                icon: Icons.cloud_upload_rounded,
                title: '数据备份 (导出)',
                onTap: () => _exportData(context),
              ),
              _buildSettingTile(
                icon: Icons.cloud_download_rounded,
                title: '数据恢复 (导入)',
                onTap: () => _importData(context, ref),
              ),
              _buildSettingTile(
                icon: Icons.download_for_offline_rounded,
                title: '资源下载',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ResourceDownloadScreen()),
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
            BoxShadow(color: AppColors.primary.withValues(alpha: 0.05), spreadRadius: 1),
            BoxShadow(color: AppColors.textMain.withValues(alpha: 0.02), offset: const Offset(0, 4), blurRadius: 10),
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
            if (trailing != null) trailing else Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary.withValues(alpha: 0.3)),
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

  Future<void> _exportData(BuildContext context) async {
    try {
      await DatabaseBackupService().exportDatabase();
    } catch (e) {
      if (context.mounted) {
        AppDialogs.showError(context, "导出失败: $e");
      }
    }
  }

  Future<void> _importData(BuildContext context, WidgetRef ref) async {
    final confirmed = await AppDialogs.showConfirm(
      context: context,
      title: '确认恢复数据？',
      message: '恢复数据将覆盖当前所有数据，建议先备份当前数据.\n\n恢复成功后应用需要重启。',
      confirmText: '选择文件',
      isDanger: true,
    );

    if (confirmed) {
      try {
        final db = ref.read(databaseProvider);
        final success = await DatabaseBackupService(db).importDatabase();
        if (success && context.mounted) {
          await AppDialogs.showSuccess(context, "数据恢复成功！\n请重启应用以生效。");
        }
      } catch (e) {
        if (context.mounted) {
          AppDialogs.showError(context, "恢复失败: $e");
        }
      }
    }
  }
}
