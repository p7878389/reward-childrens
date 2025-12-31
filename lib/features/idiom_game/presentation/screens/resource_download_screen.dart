import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/resource_entities.dart';
import 'package:children_rewards/features/idiom_game/providers/idiom_game_providers.dart';
import 'package:children_rewards/features/idiom_game/services/resource_download_service.dart';

import 'package:children_rewards/shared/widgets/common_widgets.dart';

class ResourceDownloadScreen extends ConsumerWidget {
  const ResourceDownloadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 假设我们有一个合并的资源状态提供者
    // final status = ref.watch(resourceStatusProvider);
    // For now, let's use a placeholder
    final status = {
      ResourceType.voskModel: const DownloadProgress(type: ResourceType.voskModel, status: DownloadStatus.idle),
    };

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(title: "资源管理"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildResourceCard(
                    context,
                    ref,
                    type: ResourceType.voskModel,
                    title: "语音模型",
                    subtitle: "~45 MB",
                    icon: Icons.mic_rounded,
                    progress: status[ResourceType.voskModel]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context,
    WidgetRef ref, {
    required ResourceType type,
    required String title,
    required String subtitle,
    required IconData icon,
    required DownloadProgress progress,
  }) {
    final theme = Theme.of(context);
    final service = ref.read(resourceDownloadServiceProvider);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary, size: 32),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleLarge),
                    Text(subtitle, style: theme.textTheme.bodySmall),
                  ],
                ),
                const Spacer(),
                _buildStatusButton(context, type, progress.status, service),
              ],
            ),
            if (progress.status == DownloadStatus.downloading) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(value: progress.progress),
            ],
            if (progress.error != null) ...[
              const SizedBox(height: 8),
              Text(progress.error!, style: TextStyle(color: theme.colorScheme.error)),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(BuildContext context, ResourceType type, DownloadStatus status, ResourceDownloadService service) {
    switch (status) {
      case DownloadStatus.idle:
        return ElevatedButton(onPressed: () => service.startDownload(type), child: const Text("下载"));
      case DownloadStatus.downloading:
      case DownloadStatus.extracting:
      case DownloadStatus.importing:
        return const CircularProgressIndicator();
      case DownloadStatus.completed:
        return const Icon(Icons.check_circle, color: Colors.green, size: 32);
      case DownloadStatus.error:
        return IconButton(icon: const Icon(Icons.refresh), onPressed: () => service.startDownload(type));
      default:
        return const SizedBox.shrink();
    }
  }
}
