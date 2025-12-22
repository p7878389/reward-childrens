import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/rule/providers/rules_providers.dart';
import 'package:children_rewards/features/rule/utils/rule_localization.dart';
import 'package:children_rewards/shared/widgets/swipeable_card.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'add_rule_screen.dart';
import 'edit_rule_screen.dart';

class RulesManageScreen extends ConsumerStatefulWidget {
  const RulesManageScreen({super.key});

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => Navigator.pop(context)),
                  const SizedBox.shrink(),
                  HeaderButton(
                      icon: Icons.add_rounded,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddRuleScreen()),
                        );
                      }),
                ],
              ),
            ),

            // Mode Switcher
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2EFE5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    _buildModeBtn(l10n.reward, 'reward',
                        Icons.add_circle_outline, const Color(0xFF16A34A)),
                    _buildModeBtn(l10n.punish, 'punish',
                        Icons.remove_circle_outline, const Color(0xFFDC2626)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

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
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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

  Widget _buildModeBtn(
      String label, String value, IconData icon, Color activeColor) {
    final isSelected = _mode == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => _switchMode(value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05), blurRadius: 4)
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 18,
                  color: isSelected
                      ? activeColor
                      : AppColors.textSecondary.withOpacity(0.5)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? activeColor
                      : AppColors.textSecondary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleItem(BuildContext context, Rule rule, AppLocalizations l10n) {
    final isReward = rule.type == 'reward';
    final isActive = rule.isActive;

    final pointsColor = !isActive
        ? AppColors.textSecondary.withOpacity(0.4)
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
                  BoxShadow(color: AppColors.primary.withOpacity(0.05), spreadRadius: 1),
                  BoxShadow(color: AppColors.textMain.withOpacity(0.02), offset: const Offset(0, 4), blurRadius: 10),
                ] : null,
                border: isActive ? null : Border.all(color: Colors.black.withOpacity(0.03)),
              ),
              child: Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    color: !isActive
                        ? Colors.grey.withOpacity(0.1)
                        : (isReward ? const Color(0xFFEFF6FF) : const Color(0xFFFEF2F2)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    _getIconData(rule.icon),
                    color: !isActive
                        ? Colors.grey.withOpacity(0.5)
                        : (isReward ? Colors.blue : Colors.red),
                    size: 24,
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
                          color: isActive ? AppColors.textMain : AppColors.textMain.withOpacity(0.4),
                        )
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: pointsColor.withOpacity(0.1),
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
                    activeColor: AppColors.primary,
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

  void _switchMode(String mode) {
    setState(() {
      _mode = mode;
    });
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

  IconData _getIconData(String? iconName) {
    switch (iconName) {
      case 'menu_book':
        return Icons.menu_book_rounded;
      case 'cleaning_services':
        return Icons.cleaning_services_rounded;
      case 'sentiment_dissatisfied':
        return Icons.sentiment_dissatisfied_rounded;
      case 'warning':
        return Icons.warning_rounded;
      case 'star':
        return Icons.star_rounded;
      default:
        return Icons.category_rounded;
    }
  }
}
