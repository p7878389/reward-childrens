import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/features/children/data/children_repository.dart';
import 'package:children_rewards/shared/utils/form_validator.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/shared/widgets/custom_input_field.dart';

class EditChildScreen extends ConsumerStatefulWidget {
  final ChildrenData child;

  const EditChildScreen({super.key, required this.child});

  @override
  ConsumerState<EditChildScreen> createState() => _EditChildScreenState();
}

class _EditChildScreenState extends ConsumerState<EditChildScreen> {
  late TextEditingController _nameController;
  late String _gender;
  DateTime? _birthday;
  String _avatarData = 'builtin:0';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.child.name);
    _gender = widget.child.gender;
    if (widget.child.birthday != null) {
      try {
        _birthday = DateTime.parse(widget.child.birthday!);
      } catch (_) {}
    }

    // Initialize Avatar
    if (widget.child.avatar != null) {
      _avatarData = widget.child.avatar!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => Navigator.pop(context)),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.primary.withOpacity(0.1),
                            spreadRadius: 1)
                      ],
                    ),
                    child: Text(l10n.editProfile.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                            letterSpacing: 1.1)),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  // Avatar Section
                  AvatarPicker(
                    initialAvatar: _avatarData,
                    onAvatarChanged: (val) => setState(() => _avatarData = val),
                    hintText: l10n.tapPhoto,
                  ),
                  const SizedBox(height: 32),

                  // Name Input
                  _buildLabel(l10n.childName),
                  const SizedBox(height: 8),
                  CustomInputField(
                    controller: _nameController,
                    icon: Icons.person_rounded,
                    hintText: l10n.childName,
                    onChanged: (v) => setState(() {}),
                  ),
                  const SizedBox(height: 20),

                  // Gender Selection
                  _buildLabel(l10n.gender),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                          child: _buildGenderCard(
                              'boy', Icons.male, Colors.blue, l10n.boy)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildGenderCard(
                              'girl', Icons.female, Colors.pink, l10n.girl)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Birthday Input
                  _buildLabel(l10n.birthdayOptional),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      // 取消焦点隐藏键盘
                      FocusScope.of(context).unfocus();
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _birthday ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() => _birthday = date);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.05)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.cake_rounded,
                              color: AppColors.textSecondary, size: 20),
                          const SizedBox(width: 12),
                          Text(
                            _birthday == null
                                ? l10n.selectDate
                                : DateFormat('yyyy-MM-dd').format(_birthday!),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _birthday == null
                                  ? AppColors.textSecondary.withOpacity(0.5)
                                  : AppColors.textMain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Save Button
                  const SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      width: 220,
                      height: 48,
                      child: ElevatedButton(
                        onPressed:
                            _nameController.text.isEmpty ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          elevation: 2,
                          shadowColor: AppColors.primary.withOpacity(0.3),
                        ),
                        child: Text(l10n.saveChanges,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
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

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    final name = _nameController.text.trim();

    // 校验姓名
    if (name.isEmpty) {
      FormValidator.showError(context, l10n.nameRequired);
      return;
    }

    final updatedChild = ChildrenData(
      id: widget.child.id,
      name: name,
      gender: _gender,
      birthday: _birthday?.toIso8601String(),
      avatar: _avatarData,
      stars: widget.child.stars,
      createdAt: widget.child.createdAt,
      updatedAt: DateTime.now(),
      isDeleted: widget.child.isDeleted,
    );

    try {
      await ref.read(childrenRepositoryProvider).updateChild(updatedChild);
      if (mounted) {
        await AppDialogs.showSuccess(context, l10n.saveSuccess);
        if (mounted) Navigator.pop(context);
      }
    } catch (e, stackTrace) {
      logError('更新宝贝信息失败', tag: 'EditChildScreen', error: e, stackTrace: stackTrace);
      if (mounted) {
        FormValidator.showError(context, 'Failed to save changes: $e');
      }
    }
  }

  Widget _buildGenderCard(
      String value, IconData icon, Color color, String localizedLabel) {
    final isSelected = _gender == value;
    return GestureDetector(
      onTap: () => setState(() => _gender = value),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected ? color : Colors.black.withOpacity(0.05)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: isSelected
                    ? color
                    : AppColors.textSecondary.withOpacity(0.5),
                size: 20),
            const SizedBox(width: 8),
            Text(
              localizedLabel.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? color : AppColors.textSecondary,
              ),
            ),
          ],
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
