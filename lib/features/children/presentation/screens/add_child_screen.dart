import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/features/children/data/children_repository.dart';
import 'package:children_rewards/shared/utils/form_validator.dart';
import 'package:children_rewards/shared/widgets/custom_input_field.dart';

class AddChildScreen extends ConsumerStatefulWidget {
  const AddChildScreen({super.key});

  @override
  ConsumerState<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends ConsumerState<AddChildScreen> {
  final _nameController = TextEditingController();
  String _gender = 'boy';
  DateTime? _birthday;
  String _avatarData = 'builtin:0';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.addProfile.toUpperCase(),
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1.1),
        ),
        leading: HeaderButton(icon: Icons.arrow_back_ios_new_rounded, onTap: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  const SizedBox(height: 16),
                  _buildLabel(l10n.avatar),
                  const SizedBox(height: 8),
                  AvatarPicker(
                    initialAvatar: _avatarData,
                    onAvatarChanged: (val) => setState(() => _avatarData = val),
                    hintText: l10n.tapPhoto,
                  ),
                  const SizedBox(height: 24),

                  _buildLabel(l10n.childName),
                  const SizedBox(height: 8),
                  CustomInputField(
                    controller: _nameController,
                    icon: Icons.person_rounded,
                    hintText: l10n.childName,
                    onChanged: (v) => setState(() {}),
                  ),
                  const SizedBox(height: 20),

                  _buildLabel(l10n.gender),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _buildGenderCard('boy', Icons.male, Colors.blue, l10n.boy)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildGenderCard('girl', Icons.female, Colors.pink, l10n.girl)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  _buildLabel(l10n.birthdayOptional),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
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
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black.withOpacity(0.05)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.cake_rounded, color: AppColors.textSecondary, size: 20),
                          const SizedBox(width: 12),
                          Text(
                            _birthday == null ? l10n.selectDate : DateFormat('yyyy-MM-dd').format(_birthday!),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _birthday == null ? AppColors.textSecondary.withOpacity(0.5) : AppColors.textMain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _nameController.text.isEmpty ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                        elevation: 2,
                        shadowColor: AppColors.primary.withOpacity(0.3),
                      ),
                      child: Text(l10n.createProfile, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

    if (name.isEmpty) {
      FormValidator.showError(context, l10n.nameRequired);
      return;
    }

    try {
      await ref.read(childrenRepositoryProvider).createChild(
        name: name,
        gender: _gender,
        birthday: _birthday?.toIso8601String(),
        avatar: _avatarData,
      );
      if (mounted) {
        await AppDialogs.showSuccess(context, l10n.addSuccess);
        if (mounted) Navigator.pop(context);
      }
    } catch (e, stackTrace) {
      logError('创建宝贝失败', tag: 'AddChildScreen', error: e, stackTrace: stackTrace);
      if (mounted) {
        FormValidator.showError(context, 'Failed to create profile: $e');
      }
    }
  }

  Widget _buildGenderCard(String value, IconData icon, Color color, String localizedLabel) {
    final isSelected = _gender == value;
    return GestureDetector(
      onTap: () => setState(() => _gender = value),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? color : Colors.black.withOpacity(0.05)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? color : AppColors.textSecondary.withOpacity(0.5), size: 20),
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
      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.5),
    );
  }
}