import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/theme/app_dimens.dart';
import 'package:children_rewards/features/rule/providers/rules_providers.dart';
import 'package:children_rewards/features/rule/utils/rule_localization.dart';
import 'package:children_rewards/features/rule/utils/rule_icons.dart';
import 'package:children_rewards/shared/widgets/swipeable_card.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'add_rule_screen.dart';
import 'edit_rule_screen.dart';

class RulesManageScreen extends ConsumerStatefulWidget {
  /// 是否显示返回按钮，作为 tab 页面时设为 false
  final bool showBackButton;

  const RulesManageScreen({super.key, this.showBackButton = true});

  @override
  ConsumerState<RulesManageScreen> createState() => _RulesManageScreenState();
}

class _RulesManageScreenState extends ConsumerState<RulesManageScreen> {
  String _mode = 'reward'; // 'reward' or 'punish' (数据库约束)

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return const Scaffold();

    final rulesAsync = ref.watch(rulesStreamProvider(_mode));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Add Button
            AppHeader(
              title: l10n.rules,
              showBack: widget.showBackButton,
              actions: [
                HeaderButton(
                  icon: Icons.add_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddRuleScreen()),
                    );
                  }
                ),
              ],
            ),

            // Mode Switcher
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingL, vertical: 8),
              child: CommonFilterTabs(
                selectedValue: _mode,
                onSelect: (val) => setState(() => _mode = val),
                tabs: [
                  FilterTabData(label: l10n.reward, value: 'reward'),
                  FilterTabData(label: l10n.punish, value: 'punish'),
                ],
              ),
            ),

            const SizedBox(height: AppDimens.paddingM),

            // Rules List
            Expanded(
              child: rulesAsync.when(
                data: (rules) {
                  if (rules.isEmpty) {
                    return const EmptyState(icon: Icons.history_rounded);
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(rulesStreamProvider(_mode));
                    },
                    color: AppColors.primary,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingL),
                      itemCount: rules.length,
                      itemBuilder: (context, index) {
                        final rule = rules[index];
                        return _buildRuleItem(context, rule, l10n);
                      },
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleItem(BuildContext context, Rule rule, AppLocalizations l10n) {
    final isReward = rule.type == 'reward';
    final isActive = rule.isActive;

    final pointsColor = !isActive
        ? AppColors.textSecondary.withValues(alpha: 0.4)
        : (isReward ? const Color(0xFF16A34A) : const Color(0xFFDC2626));
    final pointsSign = isReward ? '+' : '-';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SwipeableCard(
        itemKey: ValueKey(rule.id),
        enabled: rule.isEditable,
        onDelete: () => _confirmDelete(context, rule, l10n),
        child: GestureDetector(
          onTap: rule.isEditable ? () => _editRule(context, rule) : null,
          child: Opacity(
            opacity: isActive ? 1.0 : 0.5,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isActive ? AppColors.surface : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(24),
                boxShadow: isActive ? [
                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.05), spreadRadius: 1),
                  BoxShadow(color: AppColors.textMain.withValues(alpha: 0.02), offset: const Offset(0, 4), blurRadius: 10),
                ] : null,
                border: isActive ? null : Border.all(color: Colors.black.withValues(alpha: 0.03)),
              ),
              child: Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    color: !isActive
                        ? Colors.grey.withValues(alpha: 0.1)
                        : (isReward ? const Color(0xFFEFF6FF) : const Color(0xFFFEF2F2)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: RuleIcons.buildIconOrImage(
                    rule.icon,
                    size: 24,
                    color: !isActive
                        ? Colors.grey.withValues(alpha: 0.5)
                        : (isReward ? Colors.blue : Colors.red),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getLocalizedRuleName(rule, l10n),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isActive ? AppColors.textMain : AppColors.textMain.withValues(alpha: 0.4),
                        )
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: pointsColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '$pointsSign${rule.points}',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: pointsColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: rule.isActive,
                    activeThumbColor: AppColors.primary,
                    onChanged: rule.isEditable ? (val) {
                      ref.read(rulesRepositoryProvider).toggleRuleStatus(rule.id, val);
                    } : null,
                  ),
                ),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _editRule(BuildContext context, Rule rule) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditRuleScreen(rule: rule)),
    );
  }

  void _confirmDelete(BuildContext context, Rule rule, AppLocalizations l10n) {
    SwipeDeleteHelper.showDeleteConfirmDialog(
      context: context,
      title: l10n.deleteConfirm(getLocalizedRuleName(rule, l10n)),
      message:
          l10n.deleteConfirmMessageCommon(getLocalizedRuleName(rule, l10n)),
      onConfirm: () {
        ref.read(rulesRepositoryProvider).deleteRule(rule.id);
      },
    );
  }
}
