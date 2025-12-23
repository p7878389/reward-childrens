import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/rewards/providers/rewards_providers.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/shared/widgets/custom_input_field.dart';

class EditRewardScreen extends ConsumerStatefulWidget {
  final Reward reward;

  const EditRewardScreen({super.key, required this.reward});

  @override
  ConsumerState<EditRewardScreen> createState() => _EditRewardScreenState();
}

class _EditRewardScreenState extends ConsumerState<EditRewardScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  String _category = 'other';
  String? _imagePath;
  bool _isUnlimited = true;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.reward.name);
    _descController = TextEditingController(text: widget.reward.description);
    _priceController = TextEditingController(text: widget.reward.price.toString());
    _stockController = TextEditingController(text: widget.reward.stock?.toString());
    _category = widget.reward.category;
    _imagePath = widget.reward.image;
    _isUnlimited = widget.reward.stock == null;
    _isActive = widget.reward.isActive;
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
                color: AppColors.textSecondary.withOpacity(0.2),
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
      final fileName = path.basename(pickedFile.path);
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');
      setState(() {
        _imagePath = savedImage.path;
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
            border: Border.all(color: AppColors.primary.withOpacity(0.1)),
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
      isActive: drift.Value(_isActive),
      updatedAt: drift.Value(DateTime.now()),
    );

    await ref.read(rewardsRepositoryProvider).updateReward(widget.reward.id, companion);

    if (mounted) {
      await AppDialogs.showSuccess(context, l10n.saveSuccess);
      if (mounted) Navigator.pop(context);
    }
  }

  void _deleteReward() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await AppDialogs.showDeleteConfirm(
      context: context,
      title: l10n.deleteConfirm(widget.reward.name),
      message: l10n.deleteUndone,
    );

    if (confirmed) {
      await ref.read(rewardsRepositoryProvider).deleteReward(widget.reward.id);
      if (mounted) {
        Navigator.pop(context);
      }
    }
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
          l10n.editReward.toUpperCase(),
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1.1),
        ),
        leading: HeaderButton(icon: Icons.arrow_back_ios_new_rounded, onTap: () => Navigator.pop(context)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626)),
            onPressed: _deleteReward,
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
                  _buildPreviewCard(l10n),
                  const SizedBox(height: 24),
                  
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
                          border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 2),
                          boxShadow: [
                            BoxShadow(color: AppColors.primary.withOpacity(0.1), spreadRadius: 1),
                            BoxShadow(color: AppColors.textMain.withOpacity(0.03), offset: const Offset(0, 4), blurRadius: 10),
                          ],
                        ),
                        child: _imagePath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(22),
                                child: Image.file(File(_imagePath!), fit: BoxFit.cover),
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
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
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
                          activeColor: AppColors.primary,
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

                  const SizedBox(height: 32),

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
                          l10n.rewardActiveStatus,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMain),
                        ),
                        Switch(
                          value: _isActive,
                          activeColor: AppColors.primary,
                          onChanged: (val) => setState(() => _isActive = val),
                        ),
                      ],
                    ),
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

  Widget _buildPreviewCard(AppLocalizations l10n) {
    return Opacity(
      opacity: _isActive ? 1.0 : 0.6,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: AppColors.primary.withOpacity(0.05), spreadRadius: 1),
            BoxShadow(color: AppColors.textMain.withOpacity(0.02), offset: const Offset(0, 4), blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: _buildRewardIcon(),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded, size: 18, color: Color(0xFFD97706)),
                          const SizedBox(width: 4),
                          Text(
                            _priceController.text.isEmpty ? '0' : _priceController.text,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFFD97706)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.textSecondary.withOpacity(0.1)),
                        ),
                        child: Text(
                          _getLocalizedCategory(_category, l10n).toUpperCase(),
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textSecondary.withOpacity(0.8)),
                        ),
                      ),
                      if (!_isUnlimited)
                        Row(
                          children: [
                            Icon(Icons.inventory_2_outlined, size: 12, color: AppColors.textSecondary.withOpacity(0.6)),
                            const SizedBox(width: 2),
                            Text(
                              _stockController.text,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary.withOpacity(0.6)),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _nameController.text.isEmpty ? l10n.rewardName : _nameController.text,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textMain, height: 1.2),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 32,
                    child: Text(
                      _descController.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary.withOpacity(0.8),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardIcon() {
    if (_imagePath != null) {
      final file = File(_imagePath!);
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: Image.file(file, fit: BoxFit.cover, width: double.infinity,),
        );
      }
    }
    return const Icon(Icons.card_giftcard_rounded, color: Color(0xFFD97706), size: 40);
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
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
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
