import 'package:flutter/material.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';

class RewardCard extends StatelessWidget {
  final Reward reward;
  final VoidCallback? onTap;
  final bool isAffordable;
  final bool isOutOfStock;

  const RewardCard({
    super.key,
    required this.reward,
    this.onTap,
    this.isAffordable = true,
    this.isOutOfStock = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isOutOfStock ? null : onTap,
      child: Opacity(
        opacity: isOutOfStock ? 0.6 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.05),
                spreadRadius: 1,
              ),
              BoxShadow(
                color: AppColors.textMain.withValues(alpha: 0.02),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Area
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      child: RepaintBoundary(
                        child: _buildRewardImage(),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, size: 14, color: Color(0xFFD97706)),
                            const SizedBox(width: 2),
                            Text(
                              reward.price.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: isAffordable ? const Color(0xFFD97706) : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isOutOfStock)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                "OUT OF STOCK",
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              // Content Area
              Container(
                height: 76,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reward.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isOutOfStock ? Colors.grey : AppColors.textMain,
                        height: 1.2,
                        decoration: isOutOfStock ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const Spacer(),
                    // Consistent height for description (2 lines)
                    SizedBox(
                      height: 28, // Adjusted to fit 2 lines cleanly
                      child: Text(
                        reward.description ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary.withValues(alpha: 0.8),
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardImage() {
    return PersistentImage(
      imagePath: reward.image,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      placeholder: Center(
        child: Icon(
          Icons.card_giftcard_rounded,
          color: const Color(0xFFD97706).withValues(alpha: 0.5),
          size: 48,
        ),
      ),
    );
  }
}
