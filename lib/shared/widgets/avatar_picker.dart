import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/constants/avatar_data.dart';
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/core/services/file_storage_service.dart';

/// 后台处理图片：裁剪为正方形并压缩
/// 必须是顶层函数才能在 Isolate 中运行
Uint8List _processImageInBackground(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return bytes;
  // 裁剪为正方形并调整大小至 512x512
  final processed = img.copyResizeCropSquare(decoded, size: 512);
  return Uint8List.fromList(img.encodeJpg(processed, quality: 85));
}

/// 头像选择器组件
///
/// 支持从相册选择图片或使用内置 SVG 头像
class AvatarPicker extends StatefulWidget {
  final String? initialAvatar;
  final ValueChanged<String> onAvatarChanged;
  final double size;
  final String? hintText;

  const AvatarPicker({
    super.key,
    this.initialAvatar,
    required this.onAvatarChanged,
    this.size = 100,
    this.hintText,
  });

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  final ImagePicker _picker = ImagePicker();
  File? _avatarFile;
  int _avatarIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeAvatar();
  }

  void _initializeAvatar() {
    if (widget.initialAvatar != null) {
      if (widget.initialAvatar!.startsWith('builtin:')) {
        _avatarIndex = int.tryParse(widget.initialAvatar!.split(':')[1]) ?? 0;
        _avatarFile = null;
      } else {
        // 处理文件路径 (可能是绝对路径或相对路径)
        _resolveAvatarPath(widget.initialAvatar!);
      }
    } else {
      _avatarIndex = Random().nextInt(AvatarData.builtInSvgs.length);
    }
  }

  Future<void> _resolveAvatarPath(String pathStr) async {
    try {
      String resolvedPath;
      if (pathStr.startsWith('/')) {
        // 绝对路径 - 验证在沙箱内
        resolvedPath = path.normalize(pathStr);
        final sandboxPath = FileStorageService.legacyBasePath;
        if (!resolvedPath.startsWith(sandboxPath)) {
          logError('路径遍历攻击被阻止: $pathStr', tag: 'AvatarPicker');
          return;
        }
      } else {
        // 相对路径 - 使用 FileStorageService 解析
        resolvedPath = FileStorageService.getAbsolutePath(pathStr);
      }
      setState(() => _avatarFile = File(resolvedPath));
    } catch (e) {
      logError('解析头像路径失败', tag: 'AvatarPicker', error: e);
    }
  }

  Future<void> _pickImage() async {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    // 显示底部选择弹窗
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
                  context,
                  icon: Icons.camera_alt_rounded,
                  label: l10n.takePhoto,
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                const SizedBox(width: 16),
                _buildSourceOption(
                  context,
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

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024, // 初步限制选择图片的最大宽度
        maxHeight: 1024,
      );
      
      if (image != null) {
        File fileToSave = File(image.path);

        // 在后台 Isolate 中压缩和裁剪图片
        try {
          final bytes = await fileToSave.readAsBytes();
          final processedBytes = await compute(_processImageInBackground, bytes);
          await fileToSave.writeAsBytes(processedBytes);
        } catch (e) {
          logError('图片压缩失败，将使用原图', tag: 'AvatarPicker', error: e);
          // 压缩失败则继续使用原图
        }

        // 使用 FileStorageService 保存文件
        final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final relativePath = await FileStorageService.saveFile(
          fileToSave,
          StorageModule.children,
          fileName: fileName,
        );

        setState(() {
          _avatarFile = File(FileStorageService.getAbsolutePath(relativePath));
        });

        // 传递相对路径给上层
        widget.onAvatarChanged(relativePath);
      }
    } catch (e, stackTrace) {
      logError('选择图片失败', tag: 'AvatarPicker', error: e, stackTrace: stackTrace);
    }
  }

  Widget _buildSourceOption(
    BuildContext context, {
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

  void _randomizeAvatar() {
    setState(() {
      _avatarIndex = (_avatarIndex + 1) % AvatarData.builtInSvgs.length;
      _avatarFile = null;
    });
    widget.onAvatarChanged('builtin:$_avatarIndex');
  }

  /// 获取当前头像数据字符串
  String get avatarData {
    return _avatarFile != null ? _avatarFile!.path : 'builtin:$_avatarIndex';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: AppColors.blueTag,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 4),
                    boxShadow: [
                      BoxShadow(color: AppColors.primary.withValues(alpha: 0.15), offset: const Offset(0, 4), blurRadius: 16),
                    ],
                    image: _avatarFile != null
                        ? DecorationImage(image: FileImage(_avatarFile!), fit: BoxFit.cover)
                        : null,
                  ),
                  child: _avatarFile == null
                      ? ClipOval(
                          child: SvgPicture.string(
                            AvatarData.builtInSvgs[_avatarIndex],
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: _randomizeAvatar,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 6)],
                    ),
                    child: const Icon(Icons.refresh, color: AppColors.primary, size: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.hintText != null) ...[
          const SizedBox(height: 12),
          Center(
            child: Text(
              widget.hintText!,
              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
            ),
          ),
        ],
      ],
    );
  }
}
