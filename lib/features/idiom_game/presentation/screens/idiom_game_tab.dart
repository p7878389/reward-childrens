import 'package:children_rewards/features/children/presentation/screens/add_child_screen.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';
import 'package:children_rewards/features/idiom_game/presentation/screens/grade_selection_screen.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

class IdiomGameTab extends ConsumerWidget {
  const IdiomGameTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childrenAsync = ref.watch(allChildrenStreamProvider);

    return childrenAsync.when(
      data: (children) {
        if (children.isEmpty) {
          return EmptyState(
            icon: Icons.child_care_rounded,
            message: "暂无宝贝档案",
            description: "添加宝贝后即可开始成语挑战之旅",
            actionText: "添加宝贝",
            onAction: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddChildScreen()),
              );
            },
          );
        }
        
        // 如果只有一个孩子，直接显示该孩子的游戏界面
        if (children.length == 1) {
          return GradeSelectionScreen(childId: children.first.id);
        }

        // 如果有多个孩子，显示选择列表
        return Column(
          children: [
            const AppHeader(
              title: "谁来挑战？",
              showBack: false,
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: children.length,
                itemBuilder: (context, index) {
                  final child = children[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (_) => GradeSelectionScreen(childId: child.id))
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  child.name[0], 
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              child.name, 
                              style: const TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.w900,
                                color: AppColors.textMain,
                              )
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textSecondary),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
