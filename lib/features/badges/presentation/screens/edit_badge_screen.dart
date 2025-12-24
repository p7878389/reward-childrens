import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/providers/badge_providers.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/shared/widgets/custom_input_field.dart';

import 'package:children_rewards/features/badges/presentation/widgets/badge_icon_picker.dart';

class EditBadgeScreen extends ConsumerStatefulWidget {
  final BadgeEntity badge;

  const EditBadgeScreen({super.key, required this.badge});

  @override
  ConsumerState<EditBadgeScreen> createState() => _EditBadgeScreenState();
}

class _EditBadgeScreenState extends ConsumerState<EditBadgeScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _thresholdController;
  late TextEditingController _bonusController;
  late BadgeTriggerType _selectedType;
  late String _selectedIcon;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.badge.name);
    _descController = TextEditingController(text: widget.badge.description);
    _thresholdController = TextEditingController(text: widget.badge.triggerThreshold.toString());
    _bonusController = TextEditingController(text: widget.badge.bonusPoints.toString());
    _selectedType = widget.badge.triggerType;
    _selectedIcon = widget.badge.icon;
    _isActive = widget.badge.isActive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _thresholdController.dispose();
    _bonusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              title: '编辑徽章',
              actions: [
                HeaderButton(
                  icon: Icons.delete_outline_rounded,
                  onTap: _deleteBadge,
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  Center(
                    child: Column(
                      children: [
                        BadgeIconPicker(
                          icon: _selectedIcon,
                          onIconChanged: (val) => setState(() => _selectedIcon = val),
                          size: 80,
                        ),
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
                    initialValue: _selectedType,
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
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('启用徽章', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Switch(
                        value: _isActive,
                        onChanged: (value) {
                          setState(() {
                            _isActive = value;
                          });
                        },
                      )
                    ],
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

  void _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final threshold = int.tryParse(_thresholdController.text) ?? 0;
    final bonus = int.tryParse(_bonusController.text) ?? 0;
    
    final badge = BadgeEntity(
      id: widget.badge.id,
      name: name,
      description: _descController.text,
      icon: _selectedIcon,
      triggerType: _selectedType,
      triggerThreshold: threshold,
      bonusPoints: bonus,
      level: 1,
      isActive: _isActive,
      isSystem: widget.badge.isSystem,
      createdAt: widget.badge.createdAt,
      updatedAt: DateTime.now(),
    );

    await ref.read(badgeRepositoryProvider).update(badge);
    
    if (mounted) {
      Navigator.pop(context);
    }
  }

  void _deleteBadge() async {
    final confirmed = await AppDialogs.showDeleteConfirm(
      context: context,
      title: '删除徽章',
      message: '确定要删除徽章"${widget.badge.name}"吗？这将无法撤销。',
      confirmText: '删除'
    );

    if (confirmed == true && mounted) {
      await ref.read(badgeRepositoryProvider).delete(widget.badge.id);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
