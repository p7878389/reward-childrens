import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/rewards/providers/rewards_providers.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/shared/widgets/custom_input_field.dart';

class AddRewardScreen extends ConsumerStatefulWidget {
  const AddRewardScreen({super.key});

  @override
  ConsumerState<AddRewardScreen> createState() => _AddRewardScreenState();
}

class _AddRewardScreenState extends ConsumerState<AddRewardScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  String _category = 'other';
  String? _imagePath;
  bool _isUnlimited = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _priceController = TextEditingController(text: '10');
    _stockController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final l10n = AppLocalizations.of(context)!;
    
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
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
                color: AppColors.textSecondary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              l10n.choosePhotoSource,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.textMain,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                _buildSourceOption(
                  icon: Icons.camera_alt_rounded,
                  label: l10n.takePhoto,
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                const SizedBox(width: 16),
                _buildSourceOption(
                  icon: Icons.photo_library_rounded,
                  label: l10n.chooseFromGallery,
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final rewardsDir = Directory('${appDir.path}/rewards');
      if (!rewardsDir.existsSync()) {
        await rewardsDir.create(recursive: true);
      }

      final fileName = 'reward_${DateTime.now().millisecondsSinceEpoch}${path.extension(pickedFile.path)}';
      await File(pickedFile.path).copy('${rewardsDir.path}/$fileName');
      
      setState(() {
        _imagePath = 'rewards/$fileName';
      });
    }
  }

  Widget _buildSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary, size: 32),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    final l10n = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    final price = int.tryParse(_priceController.text) ?? 0;
    
    if (name.isEmpty) {
      AppDialogs.showError(context, l10n.nameRequired);
      return;
    }

    if (price <= 0) {
      AppDialogs.showError(context, l10n.numberMustBePositive);
      return;
    }

    int? stock;
    if (!_isUnlimited) {
      final stockVal = int.tryParse(_stockController.text);
      if (stockVal == null || stockVal < 0) {
        AppDialogs.showError(context, l10n.invalidNumber);
        return;
      }
      stock = stockVal;
    }

    final companion = RewardsCompanion(
      name: drift.Value(name),
      description: drift.Value(_descController.text),
      price: drift.Value(price),
      category: drift.Value(_category),
      stock: drift.Value(stock),
      image: drift.Value(_imagePath),
      isActive: const drift.Value(true),
      updatedAt: drift.Value(DateTime.now()),
      createdAt: drift.Value(DateTime.now()),
      isDeleted: const drift.Value(false),
    );

    await ref.read(rewardsRepositoryProvider).createReward(companion);

    if (mounted) {
      await AppDialogs.showSuccess(context, l10n.addSuccess);
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: l10n.addReward),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  const SizedBox(height: 16),
                  _buildLabel(l10n.rewardImage),
                  const SizedBox(height: 8),
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 120, height: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
                        ),
                        child: _imagePath != null
                            ? PersistentImage(
                                imagePath: _imagePath,
                                borderRadius: BorderRadius.circular(22),
                              )
                            : const Icon(Icons.add_a_photo_rounded, color: AppColors.primary, size: 40),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  _buildLabel(l10n.rewardName),
                  const SizedBox(height: 8),
                  CustomInputField(
                    controller: _nameController,
                    icon: Icons.edit_rounded,
                    hintText: 'e.g. LEGO Set',
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 24),

                  _buildLabel(l10n.points),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                          controller: _priceController,
                          icon: Icons.star_rounded,
                          keyboardType: TextInputType.number,
                          hintText: '0',
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildQuickPointBtn(10),
                      const SizedBox(width: 8),
                      _buildQuickPointBtn(50),
                      const SizedBox(width: 8),
                      _buildQuickPointBtn(100),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildLabel(l10n.category),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _category,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
                        items: ['privileges', 'toys', 'snacks', 'other']
                            .map((c) => DropdownMenuItem(value: c, child: Text(
                                _getLocalizedCategory(c, l10n).toUpperCase(),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMain, fontSize: 14),
                              )))
                            .toList(),
                        onChanged: (val) => setState(() => _category = val!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLabel(l10n.unlimitedStock),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: _isUnlimited,
                          activeThumbColor: AppColors.primary,
                          onChanged: (val) => setState(() => _isUnlimited = val),
                        ),
                      ),
                    ],
                  ),
                  
                  if (!_isUnlimited) ...[
                    const SizedBox(height: 12),
                    _buildLabel(l10n.availableQuantity),
                    const SizedBox(height: 8),
                    CustomInputField(
                      controller: _stockController,
                      icon: Icons.inventory_2_rounded,
                      keyboardType: TextInputType.number,
                      hintText: '0',
                      onChanged: (_) => setState(() {}),
                    ),
                  ],
                  
                  const SizedBox(height: 24),

                  _buildLabel(l10n.description),
                  const SizedBox(height: 8),
                  CustomInputField(
                    controller: _descController,
                    icon: Icons.description_rounded,
                    hintText: l10n.addDetails,
                    maxLines: 3,
                    onChanged: (_) => setState(() {}),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _save,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLocalizedCategory(String category, AppLocalizations l10n) {
    switch (category) {
      case 'privileges': return l10n.privileges;
      case 'toys': return l10n.toys;
      case 'snacks': return l10n.snacks;
      default: return l10n.other;
    }
  }

  Widget _buildLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.5),
    );
  }

  Widget _buildQuickPointBtn(int val) {
    return GestureDetector(
      onTap: () => setState(() => _priceController.text = val.toString()),
      child: Container(
        width: 48, height: 48,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)],
        ),
        alignment: Alignment.center,
        child: Text(
          val.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
