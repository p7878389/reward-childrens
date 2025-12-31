import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/resource_entities.dart';
import 'package:children_rewards/features/idiom_game/providers/idiom_game_providers.dart';
import 'package:children_rewards/shared/widgets/app_dialogs.dart';
import 'package:children_rewards/features/settings/presentation/screens/resource_download_screen.dart';

class IdiomResourceGuard {
  static Future<bool> ensureIdiomDb({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    return _checkAndNavigate(
      context: context,
      ref: ref,
      types: const [ResourceType.idiomDb],
      title: '成语资源未就绪',
      message: '需要下载成语资源\n是否前往下载？',
    );
  }

  static Future<bool> ensureIdiomDbAndSpeechModel({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    return _checkAndNavigate(
      context: context,
      ref: ref,
      types: const [ResourceType.idiomDb, ResourceType.voskModel],
      title: '资源未就绪',
      message: '需要下载成语资源和语音模型\n是否前往下载？',
    );
  }

  static Future<bool> _checkAndNavigate({
    required BuildContext context,
    required WidgetRef ref,
    required List<ResourceType> types,
    required String title,
    required String message,
  }) async {
    final service = ref.read(resourceDownloadServiceProvider);
    final missing = <ResourceType>[];

    for (final type in types) {
      final exists = await service.checkResourceExists(type);
      if (!exists) {
        missing.add(type);
      }
    }

    if (missing.isEmpty) return true;

    final confirmed = await AppDialogs.showConfirm(
      context: context,
      title: title,
      message: message,
      confirmText: '去下载',
    );
    
    if (confirmed) {
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ResourceDownloadScreen()),
        );
      }
    }
    
    return false;
  }
}