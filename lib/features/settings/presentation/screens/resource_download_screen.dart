import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/features/settings/presentation/providers/resource_download_provider.dart';

class ResourceDownloadScreen extends ConsumerWidget {
  const ResourceDownloadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resourceStates = ref.watch(resourceDownloadProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppHeader(
            title: '资源下载',
            dotColor: Colors.blueAccent,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: resourceDefinitions.length,
              itemBuilder: (context, index) {
                final def = resourceDefinitions[index];
                final state = resourceStates[def.id] ?? ResourceState();
                return _buildResourceCard(context, ref, def, state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context, 
    WidgetRef ref, 
    ResourceDefinition def, 
    ResourceState state
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.cloud_download_rounded, color: Colors.blueAccent),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      def.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMain,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      def.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (state.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                '错误: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          _buildActionRow(ref, def, state),
        ],
      ),
    );
  }

  String _getStatusText(ResourceState state, ResourceDefinition def) {
    if (state.status == ResourceStatus.downloading) {
      return '下载中...';
    } else if (state.status == ResourceStatus.extracting) {
      if (def.id == 'idiom_db' && state.progress > 0.9) {
        return '正在导入数据...'; // 明确提示正在进行数据库操作
      }
      return '解压安装中...';
    }
    return '';
  }

  Widget _buildActionRow(WidgetRef ref, ResourceDefinition def, ResourceState state) {
    if (state.status == ResourceStatus.downloading || state.status == ResourceStatus.extracting) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getStatusText(state, def),
                style: const TextStyle(color: Colors.blueAccent, fontSize: 12),
              ),
              Text(
                '${(state.progress * 100).toInt()}%',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: state.progress,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              minHeight: 6,
            ),
          ),
        ],
      );
    }

    final isInstalled = state.status == ResourceStatus.installed;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isInstalled)
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Row(
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.green, size: 16),
                SizedBox(width: 4),
                Text('已安装', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        
        ElevatedButton(
          onPressed: isInstalled 
              ? () => ref.read(resourceDownloadProvider.notifier).downloadResource(def.id) // 允许重新下载
              : () => ref.read(resourceDownloadProvider.notifier).downloadResource(def.id),
          style: ElevatedButton.styleFrom(
            backgroundColor: isInstalled ? Colors.white : Colors.blueAccent,
            foregroundColor: isInstalled ? Colors.blueAccent : Colors.white,
            elevation: isInstalled ? 0 : 2,
            side: isInstalled ? const BorderSide(color: Colors.blueAccent) : null,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: Text(isInstalled ? '重新下载' : '开始下载'),
        ),
      ],
    );
  }
}
