import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';
import 'package:children_rewards/core/database/app_database.dart';

/// 隐私协议内容 Provider
final privacyPolicyProvider = FutureProvider<AppContent?>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getAppContent('privacy_policy');
});

class PrivacyPolicyScreen extends ConsumerWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final contentAsync = ref.watch(privacyPolicyProvider);
    final locale = Localizations.localeOf(context);
    final isZh = locale.languageCode == 'zh';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            AppHeader(title: l10n.privacyPolicy),

            // Content
            Expanded(
              child: contentAsync.when(
                data: (content) {
                  if (content == null) {
                    return const Center(
                      child: Text('No content available'),
                    );
                  }

                  final body = isZh ? content.contentZh : content.contentEn;

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.05),
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: AppColors.textMain.withValues(alpha: 0.02),
                          offset: const Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Markdown(
                        data: body,
                        padding: const EdgeInsets.all(24),
                        styleSheet: MarkdownStyleSheet(
                          h1: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMain,
                          ),
                          h2: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMain,
                          ),
                          h3: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMain,
                          ),
                          p: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textMain,
                            height: 1.6,
                          ),
                          listBullet: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textMain,
                          ),
                          strong: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMain,
                          ),
                          em: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: AppColors.textSecondary,
                          ),
                          blockquote: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary.withValues(alpha: 0.8),
                            fontStyle: FontStyle.italic,
                          ),
                          horizontalRuleDecoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: AppColors.textSecondary.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
