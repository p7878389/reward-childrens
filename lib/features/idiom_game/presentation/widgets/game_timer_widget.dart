import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/idiom_game/presentation/providers/idiom_game_provider.dart';

/// 独立的倒计时组件，使用 select 只监听 remainingTime，避免整个游戏界面重建
class GameTimerWidget extends ConsumerWidget {
  final int childId;
  final int maxSeconds;

  const GameTimerWidget({
    super.key,
    required this.childId,
    this.maxSeconds = 60,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 使用 select 只监听 remainingTime，避免其他状态变化触发重建
    final remainingTime = ref.watch(
      idiomGameProvider(childId).select((state) => state.remainingTime),
    );

    final isWarning = remainingTime <= 5;
    final color = isWarning ? Colors.red : AppColors.primary;
    final textColor = isWarning ? Colors.red : AppColors.textMain;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            value: remainingTime / maxSeconds,
            backgroundColor: Colors.grey.shade200,
            color: color,
            strokeWidth: 3,
          ),
        ),
        Text(
          "$remainingTime",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
