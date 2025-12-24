import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/constants/icon_mappings.dart';
import 'package:children_rewards/features/rule/providers/rules_providers.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/shared/widgets/custom_input_field.dart';
import 'package:children_rewards/core/services/logger_service.dart';

class AddRuleScreen extends ConsumerStatefulWidget {
  const AddRuleScreen({super.key});

  @override
  ConsumerState<AddRuleScreen> createState() => _AddRuleScreenState();
}

class _AddRuleScreenState extends ConsumerState<AddRuleScreen> {
  String _mode = 'reward'; // 'reward' or 'punish' (数据库约束)
  final _nameController = TextEditingController();
  final _pointsController = TextEditingController(text: '10');
  String _selectedIcon = 'star';
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image =
          await _picker.pickImage(source: source, imageQuality: 50);
      if (image != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final rulesDir = Directory('${appDir.path}/rules');
        if (!rulesDir.existsSync()) {
          await rulesDir.create(recursive: true);
        }

        final fileName = 'rule_${DateTime.now().millisecondsSinceEpoch}${path.extension(image.path)}';
        await File(image.path).copy('${rulesDir.path}/$fileName');
        
        if (mounted) {
          Navigator.pop(context, 'rules/$fileName');
        }
      }
    } catch (e, stackTrace) {
      logError('选择规则图标失败', tag: 'AddRuleScreen', error: e, stackTrace: stackTrace);
    }
  }

  void _showIconPickerDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final String? selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.2),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickOption(
                      Icons.camera_alt_rounded, l10n.takePhoto, ImageSource.camera),
                  _buildImagePickOption(Icons.photo_library_rounded,
                      l10n.chooseFromGallery, ImageSource.gallery),
                ],
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
                  itemCount: RuleIconMappings.availableIcons.length,
                  itemBuilder: (context, index) {
                    final iconName = RuleIconMappings.availableIcons[index];
                    final isSelected = _selectedIcon == iconName;
                    return GestureDetector(
                      onTap: () => Navigator.pop(context, iconName),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                      color: AppColors.primary.withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4))
                                ]
                              : null,
                        ),
                        child: Icon(
                          RuleIconMappings.getIconData(iconName),
                          color: isSelected
                              ? Colors.white
                              : AppColors.textSecondary,
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

  Widget _buildImagePickOption(
      IconData icon, String label, ImageSource source) {
    return GestureDetector(
      onTap: () => _pickImage(source),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.textSecondary.withValues(alpha: 0.1)),
            ),
            child: Icon(icon, color: AppColors.textMain),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain)),
        ],
      ),
    );
  }

  Widget _buildIconOrImage(String iconDataOrPath,
      {double size = 24, Color? color}) {
    if (iconDataOrPath.contains('/') ||
        iconDataOrPath.contains(Platform.pathSeparator)) {
      return PersistentImage(
        imagePath: iconDataOrPath,
        width: size,
        height: size,
        borderRadius: BorderRadius.circular(8),
      );
    }
    return Icon(RuleIconMappings.getIconData(iconDataOrPath), size: size, color: color);
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: l10n.newRule),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  const SizedBox(height: 16),
                  // Icon Selector (Moved to top)
                  _buildLabel(l10n.chooseIcon),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _showIconPickerDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Colors.black.withValues(alpha: 0.05)),
                      ),
                      child: Row(
                        children: [
                          _buildIconOrImage(_selectedIcon,
                              color: AppColors.textSecondary, size: 20),
                          const Spacer(),
                          Icon(Icons.keyboard_arrow_right_rounded,
                              color: AppColors.textSecondary.withValues(alpha: 0.5),
                              size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Mode Switcher
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2EFE5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        _buildModeBtn(l10n.reward, 'reward',
                            Icons.add_circle_outline, const Color(0xFF16A34A)),
                        _buildModeBtn(
                            l10n.punish,
                            'punish',
                            Icons.remove_circle_outline,
                            const Color(0xFFDC2626)),
                      ],
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
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildQuickPointBtn(5),
                      const SizedBox(width: 8),
                      _buildQuickPointBtn(10),
                      const SizedBox(width: 8),
                      _buildQuickPointBtn(20),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26)),
                        elevation: 2,
                        shadowColor: AppColors.primary.withValues(alpha: 0.3),
                      ),
                      child: Text(l10n.createRule,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
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

  void _submit() async {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    final name = _nameController.text.trim();
    final points = int.tryParse(_pointsController.text) ?? 0;

    if (name.isEmpty) {
      AppDialogs.showError(context, l10n.nameRequired);
      return;
    }

    if (points <= 0) {
      AppDialogs.showError(context, l10n.numberMustBePositive);
      return;
    }

    final isDuplicate =
        await ref.read(rulesRepositoryProvider).isRuleNameExists(name);
    if (isDuplicate) {
      if (mounted) AppDialogs.showError(context, l10n.ruleNameDuplicate);
      return;
    }

    await ref.read(rulesRepositoryProvider).createRule(
          name: name,
          type: _mode,
          points: points,
          icon: _selectedIcon,
        );

    if (mounted) {
      await AppDialogs.showSuccess(context, l10n.addSuccess);
      if (mounted) Navigator.pop(context);
    }
  }

  Widget _buildModeBtn(
      String label, String value, IconData icon, Color activeColor) {
    final isSelected = _mode == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _mode = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)
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
                      : AppColors.textSecondary.withValues(alpha: 0.5)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? activeColor
                      : AppColors.textSecondary.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickPointBtn(int val, {bool enabled = true}) {
    return GestureDetector(
      onTap: enabled
          ? () => setState(() => _pointsController.text = val.toString())
          : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            val.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.textSecondary),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
          letterSpacing: 0.5),
    );
  }
}
