import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:children_rewards/core/constants/avatar_data.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/services/file_storage_service.dart';

/// 通用持久化图片显示组件
/// 
/// 能够自动处理：
/// 1. 内置 SVG (builtin:index)
/// 2. 绝对路径 (兼容旧数据)
/// 3. 相对路径 (针对 Documents 目录)
class PersistentImage extends StatefulWidget {
  final String? imagePath;
  final String? fallbackText;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BoxShape shape;
  final BorderRadius? borderRadius;
  final Widget? placeholder;

  const PersistentImage({
    super.key,
    this.imagePath,
    this.fallbackText,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.placeholder,
  });

  @override
  State<PersistentImage> createState() => _PersistentImageState();
}

class _PersistentImageState extends State<PersistentImage> {
  File? _resolvedFile;

  @override
  void initState() {
    super.initState();
    _resolvePath();
  }

  @override
  void didUpdateWidget(PersistentImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imagePath != oldWidget.imagePath) {
      _resolvePath();
    }
  }

  Future<void> _resolvePath() async {
    final pathStr = widget.imagePath;
    if (pathStr == null || pathStr.startsWith('builtin:')) {
      if (mounted) setState(() => _resolvedFile = null);
      return;
    }

    // 在微任务中执行文件检查，避免阻塞 build 流程
    Future.microtask(() async {
      if (!mounted) return;
      
      File? file;
      if (pathStr.startsWith('/')) {
        // 绝对路径
        final f = File(pathStr);
        if (await f.exists()) {
          file = f;
        }
      } else {
        // 相对路径
        try {
          final resolvedPath = FileStorageService.getAbsolutePath(pathStr);
          final f = File(resolvedPath);
          if (await f.exists()) {
            file = f;
          }
        } catch (e) {
          // ignore error
        }
      }
      
      if (mounted) {
        setState(() => _resolvedFile = file);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (widget.imagePath != null && widget.imagePath!.startsWith('builtin:')) {
      // 内置 SVG
      final index = int.tryParse(widget.imagePath!.split(':')[1]) ?? 0;
      if (index >= 0 && index < AvatarData.builtInSvgs.length) {
        content = SvgPicture.string(
          AvatarData.builtInSvgs[index],
          fit: widget.fit,
          width: widget.width,
          height: widget.height,
        );
      } else {
        content = _buildFallback();
      }
    } else if (_resolvedFile != null) {
      // 文件图片
      final cacheWidth = widget.width?.round();
      final cacheHeight = widget.height?.round();
      content = Image.file(
        _resolvedFile!,
        fit: widget.fit,
        width: widget.width,
        height: widget.height,
        cacheWidth: (cacheWidth != null && cacheWidth > 0) ? cacheWidth : null,
        cacheHeight: (cacheHeight != null && cacheHeight > 0) ? cacheHeight : null,
        errorBuilder: (_, __, ___) => _buildFallback(),
      );
    } else {
      // 默认回退
      content = _buildFallback();
    }

    // 处理形状和圆角
    Widget result = content;
    if (widget.shape == BoxShape.circle) {
      result = ClipOval(child: content);
    } else if (widget.borderRadius != null) {
      result = ClipRRect(borderRadius: widget.borderRadius!, child: content);
    }
    return result;
  }

  Widget _buildFallback() {
    if (widget.placeholder != null) return widget.placeholder!;
    
    return Container(
      width: widget.width,
      height: widget.height,
      color: AppColors.textSecondary.withValues(alpha: 0.1),
      alignment: Alignment.center,
      child: widget.fallbackText != null
          ? Text(
              widget.fallbackText!.isNotEmpty ? widget.fallbackText![0].toUpperCase() : "?",
              style: TextStyle(
                fontSize: (widget.width ?? 56) * 0.4,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            )
          : Icon(Icons.image_outlined, color: AppColors.textSecondary.withValues(alpha: 0.5)),
    );
  }
}
