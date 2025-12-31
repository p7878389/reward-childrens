import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:children_rewards/features/idiom_game/presentation/providers/idiom_puzzle_provider.dart';

class PuzzleResultDialog extends StatelessWidget {
  final IdiomPuzzleState state;
  final VoidCallback onPlayAgain;
  final VoidCallback onExit;

  const PuzzleResultDialog({
    super.key,
    required this.state,
    required this.onPlayAgain,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    final correctCount = state.results.where((r) => r.isCorrect).length;
    final totalCount = state.totalQuestions;
    final accuracy = totalCount > 0 ? (correctCount / totalCount * 100).round() : 0;

    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              accuracy >= 80 ? "🎊 太棒了！" : "💪 继续加油！",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textMain),
            ),
            const SizedBox(height: 20),
            
            // Stats Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  _buildStatItem("答对题目", "$correctCount / $totalCount", isBold: true),
                  const Divider(height: 24, thickness: 1),
                  _buildStatItem("正确率", "$accuracy%"),
                  if (!state.isReviewMode) ...[
                    _buildStatItem("获得奖励", "${state.currentStars} ⭐", color: const Color(0xFFFFB020)),
                    if (state.isPointsLimitReached)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "今日已达上限",
                          style: TextStyle(fontSize: 12, color: Colors.red[300], fontWeight: FontWeight.bold),
                        ),
                      ),
                  ] else
                    _buildStatItem("复习模式", "不计积分"),
                  if (!state.isReviewMode) ...[
                    const Divider(height: 24, thickness: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        bool isEarned = false;
                        if (index == 0 && accuracy >= 60) isEarned = true;
                        if (index == 1 && accuracy >= 80) isEarned = true;
                        if (index == 2 && accuracy >= 100) isEarned = true;
                        
                        return Icon(
                          Icons.star_rounded,
                          size: 48,
                          color: isEarned ? const Color(0xFFFFB020) : Colors.grey[300],
                        );
                      }),
                    ),
                  ],
                ],
              ),
            ),
            
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onExit,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: AppColors.textSecondary,
                    ),
                    child: const Text("返回大厅", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: onPlayAgain,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textMain,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("再来一局", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isBold ? FontWeight.w900 : FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.w900 : FontWeight.bold,
              color: color ?? AppColors.textMain,
            ),
          ),
        ],
      ),
    );
  }
}
