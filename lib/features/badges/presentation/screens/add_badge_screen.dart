import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/providers/badge_providers.dart';

import 'package:children_rewards/shared/widgets/custom_input_field.dart';

class AddBadgeScreen extends ConsumerStatefulWidget {
  const AddBadgeScreen({super.key});

  @override
  ConsumerState<AddBadgeScreen> createState() => _AddBadgeScreenState();
}

class _AddBadgeScreenState extends ConsumerState<AddBadgeScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _thresholdController;
  late TextEditingController _bonusController;
  BadgeTriggerType _selectedType = BadgeTriggerType.totalPoints;
  String _selectedIcon = 'badge_star';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _thresholdController = TextEditingController(text: '100');
    _bonusController = TextEditingController(text: '10');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _thresholdController.dispose();
    _bonusController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedIcon = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('新增徽章'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _showIconPickerOptions,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 2),
                            ),
                            child: _buildPreviewIcon(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('点击更换图标', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomInputField(
                    controller: _nameController,
                    hintText: '徽章名称',
                    icon: Icons.label_outline_rounded,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<BadgeTriggerType>(
                    value: _selectedType,
                    decoration: InputDecoration(
                      labelText: '触发条件类型',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: const [
                      DropdownMenuItem(value: BadgeTriggerType.totalPoints, child: Text('累计积分')),
                      DropdownMenuItem(value: BadgeTriggerType.consecutiveCheckin, child: Text('连续签到')),
                      DropdownMenuItem(value: BadgeTriggerType.exchangeCount, child: Text('兑换次数')),
                      DropdownMenuItem(value: BadgeTriggerType.pointsEarnedSingle, child: Text('单次获得积分')),
                    ],
                    onChanged: (val) => setState(() => _selectedType = val!),
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    controller: _thresholdController,
                    hintText: '触发阈值',
                    keyboardType: TextInputType.number,
                    icon: Icons.flag_outlined,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    controller: _bonusController,
                    hintText: '奖励积分',
                    keyboardType: TextInputType.number,
                    icon: Icons.star_outline_rounded,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: const Text('保存', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewIcon() {
    if (_selectedIcon.startsWith('/') || _selectedIcon.contains('cache') || _selectedIcon.contains('app_flutter')) {
      return ClipOval(
        child: Image.file(File(_selectedIcon), fit: BoxFit.cover),
      );
    }
    
    IconData iconData = Icons.stars_rounded;
    if (_selectedIcon.contains('calendar')) iconData = Icons.calendar_month_rounded;
    if (_selectedIcon.contains('gift')) iconData = Icons.card_giftcard_rounded;
    
    return Icon(iconData, color: AppColors.primary, size: 40);
  }

  void _showIconPickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text('从相册选择'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('拍照'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 16,
                children: [
                  _iconOption('badge_star', Icons.stars_rounded),
                  _iconOption('badge_calendar', Icons.calendar_month_rounded),
                  _iconOption('badge_gift', Icons.card_giftcard_rounded),
                  _iconOption('badge_lightning', Icons.bolt_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _iconOption(String key, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() => _selectedIcon = key);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _selectedIcon == key ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: _selectedIcon == key ? AppColors.primary : Colors.black12),
        ),
        child: Icon(icon, color: _selectedIcon == key ? AppColors.primary : Colors.grey),
      ),
    );
  }

  void _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final threshold = int.tryParse(_thresholdController.text) ?? 0;
    final bonus = int.tryParse(_bonusController.text) ?? 0;
    
    final badge = BadgeEntity(
      id: 0,
      name: name,
      description: _descController.text,
      icon: _selectedIcon,
      triggerType: _selectedType,
      triggerThreshold: threshold,
      bonusPoints: bonus,
      level: 1,
      isActive: true,
      isSystem: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await ref.read(badgeRepositoryProvider).create(badge);
    
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
