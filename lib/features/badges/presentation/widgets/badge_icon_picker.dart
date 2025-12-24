import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/core/services/file_storage_service.dart';

import 'package:children_rewards/features/badges/presentation/widgets/badge_icon.dart';

class BadgeIconPicker extends StatefulWidget {
  final String icon;
  final ValueChanged<String> onIconChanged;
  final double size;

  const BadgeIconPicker({
    super.key,
    required this.icon,
    required this.onIconChanged,
    this.size = 80,
  });

  @override
  State<BadgeIconPicker> createState() => _BadgeIconPickerState();
}

class _BadgeIconPickerState extends State<BadgeIconPicker> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _showPickOption() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Text(
              '选择图标',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 24),
            // System Icons Grid
            const Text('系统图标', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: BadgeIcon.systemIcons.length,
              itemBuilder: (context, index) {
                final item = BadgeIcon.systemIcons[index];
                final isSelected = widget.icon == item['value'];
                return GestureDetector(
                  onTap: () {
                    widget.onIconChanged(item['value']);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.background,
                      shape: BoxShape.circle,
                      border: isSelected ? Border.all(color: AppColors.primary, width: 2) : null,
                    ),
                    child: Icon(
                      item['icon'],
                      color: item['color'],
                      size: 24,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            // Custom Image Option
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add_photo_alternate_rounded, color: AppColors.primary),
              ),
              title: const Text('从相册选择图片'),
              contentPadding: EdgeInsets.zero,
              onTap: () async {
                Navigator.pop(context);
                try {
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    // 使用 FileStorageService 保存文件
                    final fileName = 'badge_${DateTime.now().millisecondsSinceEpoch}${path.extension(image.path)}';
                    final relativePath = await FileStorageService.saveFile(
                      File(image.path),
                      StorageModule.badges,
                      fileName: fileName,
                    );

                    widget.onIconChanged(relativePath);
                  }
                } catch (e, stackTrace) {
                  logError('选择徽章图片失败', tag: 'BadgeIconPicker', error: e, stackTrace: stackTrace);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPickOption,
      child: Column(
        children: [
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  offset: const Offset(0, 4),
                  blurRadius: 16,
                ),
              ],
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
            ),
            child: BadgeIcon(
              icon: widget.icon,
              size: widget.size,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '点击更换图标',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

