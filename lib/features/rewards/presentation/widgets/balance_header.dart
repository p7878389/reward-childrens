import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

class BalanceHeader extends StatelessWidget {
  final int balance;
  final String label;

  const BalanceHeader({
    super.key, 
    required this.balance,
    this.label = 'AVAILABLE STARS',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.15),
            offset: const Offset(0, 8),
            blurRadius: 30,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            top: -32,
            right: -16,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.white, size: 36),
                    const SizedBox(width: 8),
                    Text(
                      balance.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Positioned(
            right: 24,
            top: 24,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.local_mall_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}