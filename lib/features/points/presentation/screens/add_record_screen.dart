import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';
import 'package:children_rewards/features/points/providers/point_records_providers.dart';
import 'package:children_rewards/features/rule/providers/rules_providers.dart';
import 'package:children_rewards/features/rule/utils/rule_localization.dart';
import 'package:children_rewards/features/rule/utils/rule_icons.dart';
import 'package:children_rewards/shared/utils/form_validator.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';

class AddRecordScreen extends ConsumerStatefulWidget {
  final int childId;

  const AddRecordScreen({super.key, required this.childId});

  @override
  ConsumerState<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends ConsumerState<AddRecordScreen> {
  String _mode = 'earned'; // 'earned' (Reward) or 'spent' (Punish) - 用于积分记录
  Rule? _selectedRule;
  final _pointsController = TextEditingController();
  final _noteController = TextEditingController();

  // 将积分记录类型映射到规则类型（用于查询规则）
  String get _ruleType => _mode == 'earned' ? 'reward' : 'punish';

  @override
  void dispose() {
    _pointsController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onRuleSelected(Rule rule) {
    setState(() {
      _selectedRule = rule;
      _pointsController.text = rule.points.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return const Scaffold();

    final childAsync = ref.watch(childStreamProvider(widget.childId));
    final rulesAsync = ref.watch(rulesStreamProvider(_ruleType));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            AppHeader(title: l10n.addRecord),

            Expanded(
              child: childAsync.when(
                data: (child) {
                  if (child == null) return const Center(child: Text('Child not found'));

                  String ageText = "Unknown";
                  if (child.birthday != null) {
                    try {
                      final birthDate = DateTime.parse(child.birthday!);
                      final age = DateTime.now().year - birthDate.year;
                      ageText = "$age ${l10n.years}";
                    } catch (_) {}
                  }

                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 80, height: 80,
                              decoration: BoxDecoration(
                                color: AppColors.blueTag,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                                boxShadow: [
                                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.15), offset: const Offset(0, 4), blurRadius: 16),
                                ],
                              ),
                              child: AvatarImage(
                                avatar: child.avatar,
                                fallbackText: child.name,
                                size: 80,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(child.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textMain)),
                            Text(ageText, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2EFE5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            _buildModeBtn(l10n.reward, 'earned', Icons.add_circle_outline, const Color(0xFF16A34A)),
                            _buildModeBtn(l10n.punish, 'spent', Icons.remove_circle_outline, const Color(0xFFDC2626)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      _buildLabel(l10n.selectRule),
                      const SizedBox(height: 8),
                      rulesAsync.when(
                        data: (rules) {
                          final activeRules = rules.where((r) => r.isActive && !r.isDeleted).toList();
                          return _buildRuleDropdown(activeRules, l10n);
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Text('Error: $e'),
                      ),
                      const SizedBox(height: 24),

                      _buildLabel(l10n.points),
                      const SizedBox(height: 8),
                      _buildInput(
                        controller: _pointsController,
                        icon: Icons.star_rounded,
                        keyboardType: TextInputType.number,
                        hint: '0',
                      ),
                      const SizedBox(height: 24),

                      _buildLabel((_selectedRule != null && _selectedRule!.isSystem && !_selectedRule!.isEditable)
                        ? l10n.note
                        : '${l10n.note} ${l10n.optional}'),
                      const SizedBox(height: 8),
                      _buildInput(
                        controller: _noteController,
                        icon: Icons.edit_note_rounded,
                        hint: l10n.addDetails,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                            elevation: 2,
                            shadowColor: AppColors.primary.withValues(alpha: 0.3),
                          ),
                          child: Text(l10n.confirm, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
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

  void _submit() async {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    // 校验规则选择
    if (_selectedRule == null) {
      FormValidator.showError(context, l10n.pleaseSelectRule);
      return;
    }

    // 校验积分（必须大于0）
    if (!FormValidator.validatePositiveNumber(context, _pointsController.text, l10n)) {
      return;
    }

    // 仅当选择“自定义奖励”或“自定义惩罚”系统规则时，备注必填
    final isCustomSystemRule = _selectedRule!.isSystem && !(_selectedRule!.isEditable);

    if (isCustomSystemRule && !FormValidator.validateRequired(context, _noteController.text, l10n.noteRequiredForCustomRule)) {
      return;
    }

    final points = int.parse(_pointsController.text);
    
    await ref.read(pointRecordsRepositoryProvider).addRecord(
      childId: widget.childId,
      points: points,
      type: _mode,
      ruleId: _selectedRule!.id,
      ruleName: _selectedRule!.name,
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
    );

    if (mounted) {
      await AppDialogs.showSuccess(context, l10n.addSuccess);
      if (mounted) Navigator.pop(context);
    }
  }

  Widget _buildModeBtn(String label, String value, IconData icon, Color activeColor) {
    final isSelected = _mode == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _mode = value;
          _selectedRule = null;
          _pointsController.clear();
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)] : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isSelected ? activeColor : AppColors.textSecondary.withValues(alpha: 0.5)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? activeColor : AppColors.textSecondary.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleDropdown(List<Rule> rules, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Rule>(
          value: _selectedRule,
          hint: Text(l10n.chooseRule, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          isExpanded: true,
          dropdownColor: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          items: rules.map((rule) {
            return DropdownMenuItem(
              value: rule,
              child: Row(
                children: [
                  RuleIcons.buildIconOrImage(
                    rule.icon,
                    size: 24,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 12),
                  Text(getLocalizedRuleName(rule, l10n), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textMain)),
                  const Spacer(),
                  Text('${_mode == 'earned' ? '+' : '-'}${rule.points}',
                    style: TextStyle(
                      color: _mode == 'earned' ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                      fontWeight: FontWeight.w900,
                      fontSize: 12
                    )),
                ],
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) _onRuleSelected(val);
          },
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required String hint,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon, color: AppColors.textSecondary, size: 20),
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.3)),
        ),
        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMain, fontSize: 14),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.5),
    );
  }
}
