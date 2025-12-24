import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:children_rewards/features/idiom_game/presentation/providers/idiom_game_provider.dart';
import 'package:children_rewards/features/idiom_game/presentation/screens/idiom_recommendation_screen.dart';

class GameResultDialog extends StatelessWidget {
  final IdiomGameState gameState;
  final int childId;
  final VoidCallback onPlayAgain;

  const GameResultDialog({
    super.key,
    required this.gameState,
    required this.childId,
    required this.onPlayAgain,
  });

  @override
  Widget build(BuildContext context) {
    
    // Star Calculation Breakdown (Mirroring Service Logic for UI)
    final breakdown = gameState.scoreBreakdown;
    if (breakdown == null) {
      return const SizedBox();
    }

    final chainLength = gameState.chain.length;
    final baseStars = breakdown.baseStars;
    final multiplier = breakdown.gradeMultiplier;
    final speedBonus = breakdown.speedBonus;
    final hintImpact = breakdown.hintImpact;

    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "🎉 游戏结束",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textMain),
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
                  _buildBreakdownItem("接龙长度", "$chainLength 回合", isBold: true),
                  const Divider(height: 24, thickness: 1),
                  _buildBreakdownItem("基础奖励", "$baseStars ⭐"),
                  _buildBreakdownItem("年级系数", "x$multiplier"),
                  if (speedBonus > 0)
                    _buildBreakdownItem("速度奖励", "+$speedBonus ⭐", color: Colors.orange),
                  if (hintImpact != 0)
                    _buildBreakdownItem(
                      hintImpact > 0 ? "完美奖励" : "提示扣减", 
                      "${hintImpact > 0 ? '+' : ''}$hintImpact ⭐",
                      color: hintImpact > 0 ? Colors.green : Colors.red,
                    ),
                  if (breakdown.aiSurrenderBonus > 0)
                    _buildBreakdownItem("🏆 AI 认输", "+${breakdown.aiSurrenderBonus} ⭐", color: Colors.purple),
                  if (breakdown.rareIdiomBonus > 0)
                    _buildBreakdownItem("📚 生僻达人", "+${breakdown.rareIdiomBonus} ⭐", color: Colors.blue),
                  
                  const Divider(height: 24, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "总计获得",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textMain),
                      ),
                      Text(
                        "${gameState.starsEarned} ⭐",
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFFFFB020)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // View Recommendations Button
            if (gameState.chain.isNotEmpty) ...[
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    final lastIdiom = gameState.chain.last;
                    final lastChar = lastIdiom.word.characters.last;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => IdiomRecommendationScreen(
                        childId: childId,
                        lastChar: lastChar,
                        lastPinyin: lastIdiom.lastPinyin,
                      ),
                    ));
                  },
                  icon: const Icon(Icons.list_alt_rounded),
                  label: const Text("查看推荐成语", style: TextStyle(fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: AppColors.textSecondary,
                    ),
                    child: const Text("关闭", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

  Widget _buildBreakdownItem(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w900 : FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w900 : FontWeight.bold,
              color: color ?? AppColors.textMain,
            ),
          ),
        ],
      ),
    );
  }
}