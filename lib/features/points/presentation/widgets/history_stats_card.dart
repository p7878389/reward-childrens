import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

class HistoryStatsCard extends StatelessWidget {
  final int earned;
  final int spent;
  final int balance;
  final String labelBalance;
  final String labelEarned;
  final String labelDeducted;

  const HistoryStatsCard({
    super.key,
    required this.earned,
    required this.spent,
    required this.balance,
    required this.labelBalance,
    required this.labelEarned,
    required this.labelDeducted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            offset: const Offset(0, 10),
            blurRadius: 24,
            spreadRadius: -4,
          ),
        ],
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1), width: 1),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Left: Earned
            if (labelEarned.isNotEmpty)
              Expanded(
                child: _buildStatItem(
                  label: labelEarned,
                  value: '+$earned',
                  color: const Color(0xFF16A34A),
                ),
              ),
            
            if (labelEarned.isNotEmpty)
              VerticalDivider(width: 1, thickness: 1, color: AppColors.textSecondary.withValues(alpha: 0.1), indent: 8, endIndent: 8),

            // Center: Primary Metric (Balance/Total)
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    labelBalance.toUpperCase(),
                    style: TextStyle(
                      color: AppColors.textSecondary.withValues(alpha: 0.6),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    balance.toString(),
                    style: const TextStyle(
                      color: AppColors.textMain,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            ),

            VerticalDivider(width: 1, thickness: 1, color: AppColors.textSecondary.withValues(alpha: 0.1), indent: 8, endIndent: 8),

            // Right: Spent
            Expanded(
              child: _buildStatItem(
                label: labelDeducted,
                value: '-$spent',
                color: const Color(0xFFDC2626),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({required String label, required String value, required Color color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: AppColors.textSecondary.withValues(alpha: 0.6),
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
