import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/rule/providers/rules_providers.dart';
import 'package:children_rewards/features/rule/utils/rule_localization.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/shared/widgets/custom_input_field.dart';

class EditRuleScreen extends ConsumerStatefulWidget {
  final Rule rule;

  const EditRuleScreen({super.key, required this.rule});

  @override
  ConsumerState<EditRuleScreen> createState() => _EditRuleScreenState();
}

class _EditRuleScreenState extends ConsumerState<EditRuleScreen> {
  String _mode = 'reward'; // 'reward' or 'punish' (数据库约束)
  final _nameController = TextEditingController();
  final _pointsController = TextEditingController(text: '10');
  String _selectedIcon = 'star';
  bool _isActive = true;
  bool _initialized = false; // 标记是否已初始化本地化名称

  final List<String> _availableIcons = [
    'star', 'menu_book', 'cleaning_services', 'fitness_center', 'piano',
    'pets', 'bedtime', 'restaurant', 'brush', 'more_horiz', 'sports_soccer',
    'local_pizza', 'videogame_asset', 'local_library', 'computer', 'camera_alt',
    'palette', 'music_note', 'self_improvement', 'directions_walk', 'wash',
    'directions_bike', 'emoji_events', 'school', 'build', 'fastfood', 'local_hospital',
    'science', 'rowing', 'extension', 'public', 'work', 'volunteer_activism',
    'hiking', 'flight', 'beach_access', 'spa',
  ];

  void _showIconPickerDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final String? selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                l10n.chooseIcon,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textMain,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: _availableIcons.length,
                  itemBuilder: (context, index) {
                    final iconName = _availableIcons[index];
                    final isSelected = _selectedIcon == iconName;
                    return GestureDetector(
                      onTap: () => Navigator.pop(context, iconName),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : null,
                        ),
                        child: Icon(
                          _getIconData(iconName),
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    if (selected != null) {
      setState(() {
        _selectedIcon = selected;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _mode = widget.rule.type;
    _pointsController.text = widget.rule.points.toString();
    _selectedIcon = widget.rule.icon;
    _isActive = widget.rule.isActive;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final l10n = AppLocalizations.of(context);
      if (l10n != null) {
        _nameController.text = getLocalizedRuleName(widget.rule, l10n);
        _initialized = true;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final isReward = _mode == 'reward';
    final pointsColor = isReward ? const Color(0xFF16A34A) : const Color(0xFFDC2626);
    final pointsSign = isReward ? '+' : '-';
    final pointsVal = _pointsController.text.isEmpty ? '0' : _pointsController.text;

    final isEditable = widget.rule.isEditable;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.editRule.toUpperCase(),
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1.1),
        ),
        leading: HeaderButton(icon: Icons.arrow_back_ios_new_rounded, onTap: () => Navigator.pop(context)),
        actions: [
          if (isEditable)
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626)),
              onPressed: _deleteRule,
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  // Preview Card
                  Center(
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 320),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: AppColors.primary.withOpacity(0.1), spreadRadius: 1),
                          BoxShadow(color: AppColors.textMain.withOpacity(0.03), offset: const Offset(0, 4), blurRadius: 10),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48, height: 48,
                            decoration: BoxDecoration(
                              color: isReward ? const Color(0xFFEFF6FF) : const Color(0xFFFEF2F2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _getIconData(_selectedIcon),
                              color: isReward ? Colors.blue : Colors.red,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _nameController.text.isEmpty ? l10n.ruleName : _nameController.text,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: pointsColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '$pointsSign$pointsVal',
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: pointsColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Name Input
                  _buildLabel(l10n.ruleName),
                  const SizedBox(height: 8),
                  CustomInputField(
                    controller: _nameController,
                    icon: Icons.edit_rounded,
                    hintText: 'e.g. Homework',
                    onChanged: (v) => setState(() {}),
                    enabled: isEditable,
                  ),
                  const SizedBox(height: 24),

                  // Points Input
                  _buildLabel(l10n.defaultPoints),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                          controller: _pointsController,
                          icon: Icons.star_rounded,
                          keyboardType: TextInputType.number,
                          hintText: '0',
                          onChanged: (v) => setState(() {}),
                          enabled: isEditable,
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildQuickPointBtn(5, enabled: isEditable),
                      const SizedBox(width: 8),
                      _buildQuickPointBtn(10, enabled: isEditable),
                      const SizedBox(width: 8),
                      _buildQuickPointBtn(20, enabled: isEditable),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Icon Selector (New UI)
                  _buildLabel(l10n.chooseIcon),
                  const SizedBox(height: 8),
                  Opacity(
                    opacity: isEditable ? 1.0 : 0.5,
                    child: GestureDetector(
                      onTap: isEditable ? _showIconPickerDialog : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black.withOpacity(0.05)),
                        ),
                        child: Row(
                          children: [
                            Icon(_getIconData(_selectedIcon), color: AppColors.textSecondary, size: 20),
                            const Spacer(),
                            Icon(Icons.keyboard_arrow_right_rounded, color: AppColors.textSecondary.withOpacity(0.5), size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // On/Off Toggle
                  _buildLabel(l10n.dataManagement),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.ruleActiveStatus,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMain),
                        ),
                        Switch(
                          value: _isActive,
                          activeColor: AppColors.primary,
                          onChanged: isEditable ? (val) => setState(() => _isActive = val) : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Submit Button
                  if (isEditable)
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
                          shadowColor: AppColors.primary.withOpacity(0.3),
                        ),
                        child: Text(l10n.saveChanges, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteRule() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await AppDialogs.showDeleteConfirm(
      context: context,
      title: l10n.deleteConfirm(getLocalizedRuleName(widget.rule, l10n)),
      message: l10n.deleteUndone,
    );

    if (confirmed) {
      await ref.read(rulesRepositoryProvider).deleteRule(widget.rule.id);
      if (mounted) {
        Navigator.pop(context); // Pop EditRuleScreen
        Navigator.pop(context); // Pop previous screen (RuleManageScreen)
      }
    }
  }

  void _submit() async {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    final name = _nameController.text.trim();
    final points = int.tryParse(_pointsController.text) ?? 0;

    // 校验名称
    if (name.isEmpty) {
      AppDialogs.showError(context, l10n.nameRequired);
      return;
    }

    // 校验积分
    if (points <= 0) {
      AppDialogs.showError(context, l10n.numberMustBePositive);
      return;
    }

    final isDuplicate = await ref.read(rulesRepositoryProvider).isRuleNameExists(
      name,
      excludeId: widget.rule.id,
    );
    if (isDuplicate) {
      if (mounted) AppDialogs.showError(context, l10n.ruleNameDuplicate);
      return;
    }

    await ref.read(rulesRepositoryProvider).updateRule(
      id: widget.rule.id,
      name: name,
      points: points,
      icon: _selectedIcon,
    );
    await ref.read(rulesRepositoryProvider).toggleRuleStatus(widget.rule.id, _isActive);

    if (mounted) {
      await AppDialogs.showSuccess(context, l10n.saveSuccess);
      if (mounted) Navigator.pop(context);
    }
  }


  Widget _buildQuickPointBtn(int val, {bool enabled = true}) {
    return GestureDetector(
      onTap: enabled ? () => setState(() => _pointsController.text = val.toString()) : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
          ),
          alignment: Alignment.center,
          child: Text(
            val.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.5),
    );
  }

  IconData _getIconData(String? iconName) {
    switch (iconName) {
      case 'menu_book': return Icons.menu_book_rounded;
      case 'cleaning_services': return Icons.cleaning_services_rounded;
      case 'sentiment_dissatisfied': return Icons.sentiment_dissatisfied_rounded;
      case 'warning': return Icons.warning_rounded;
      case 'star': return Icons.star_rounded;
      case 'fitness_center': return Icons.fitness_center_rounded;
      case 'piano': return Icons.piano_rounded;
      case 'pets': return Icons.pets_rounded;
      case 'bedtime': return Icons.bedtime_rounded;
      case 'restaurant': return Icons.restaurant_rounded;
      case 'brush': return Icons.brush_rounded;
      case 'more_horiz': return Icons.more_horiz_rounded;
      case 'sports_soccer': return Icons.sports_soccer_rounded;
      case 'local_pizza': return Icons.local_pizza_rounded;
      case 'videogame_asset': return Icons.videogame_asset_rounded;
      case 'local_library': return Icons.local_library_rounded;
      case 'computer': return Icons.computer_rounded;
      case 'camera_alt': return Icons.camera_alt_rounded;
      case 'palette': return Icons.palette_rounded;
      case 'music_note': return Icons.music_note_rounded;
      case 'self_improvement': return Icons.self_improvement_rounded;
      case 'directions_walk': return Icons.directions_walk_rounded;
      case 'wash': return Icons.wash_rounded;
      case 'directions_bike': return Icons.directions_bike_rounded;
      case 'emoji_events': return Icons.emoji_events_rounded;
      case 'school': return Icons.school_rounded;
      case 'build': return Icons.build_rounded;
      case 'fastfood': return Icons.fastfood_rounded;
      case 'local_hospital': return Icons.local_hospital_rounded;
      case 'science': return Icons.science_rounded;
      case 'rowing': return Icons.rowing_rounded;
      case 'extension': return Icons.extension_rounded;
      case 'public': return Icons.public_rounded;
      case 'work': return Icons.work_rounded;
      case 'volunteer_activism': return Icons.volunteer_activism_rounded;
      case 'hiking': return Icons.hiking_rounded;
      case 'flight': return Icons.flight_rounded;
      case 'beach_access': return Icons.beach_access_rounded;
      case 'spa': return Icons.spa_rounded;
      default: return Icons.category_rounded;
    }
  }
}
