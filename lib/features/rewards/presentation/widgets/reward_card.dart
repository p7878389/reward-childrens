import 'dart:io';
import 'package:flutter/material.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

class RewardCard extends StatelessWidget {
  final Reward reward;
  final VoidCallback? onTap;

  const RewardCard({super.key, required this.reward, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.05),
              spreadRadius: 1,
            ),
            BoxShadow(
              color: AppColors.textMain.withOpacity(0.02),
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
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded, size: 14, color: Color(0xFFD97706)),
                          const SizedBox(width: 2),
                          Text(
                            reward.price.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFD97706),
                            ),
                          ),
                        ],
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
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                      height: 1.2,
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
                        color: AppColors.textSecondary.withOpacity(0.8),
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
    );
  }

  Widget _buildRewardImage() {
    if (reward.image != null) {
      final file = File(reward.image!);
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: Image.file(file, fit: BoxFit.cover),
        );
      }
    }
    return Center(
      child: Icon(
        Icons.card_giftcard_rounded,
        color: const Color(0xFFD97706).withOpacity(0.5),
        size: 48,
      ),
    );
  }
}
