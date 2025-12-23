import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/theme/app_colors.dart';

class CheckinSuccessDialog extends StatefulWidget {
  final int streakDays;
  final int rewardPoints;
  final bool isAlreadyCheckedin;

  const CheckinSuccessDialog({
    super.key,
    required this.streakDays,
    required this.rewardPoints,
    this.isAlreadyCheckedin = false,
  });

  @override
  State<CheckinSuccessDialog> createState() => _CheckinSuccessDialogState();
}

class _CheckinSuccessDialogState extends State<CheckinSuccessDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Icon
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: (widget.isAlreadyCheckedin ? Colors.orange : Colors.green).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.isAlreadyCheckedin ? Icons.info_outline_rounded : Icons.check_circle_rounded, 
                        color: widget.isAlreadyCheckedin ? Colors.orange : Colors.green, 
                        size: 60
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                widget.isAlreadyCheckedin ? l10n.alreadyCheckedin : l10n.checkinSuccess,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textMain),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.consecutiveCheckin(widget.streakDays),
                style: const TextStyle(fontSize: 16, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 32),
              
              // Points Reward (Only show if newly checked in)
              if (!widget.isAlreadyCheckedin) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.primary, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        '+${widget.rewardPoints}',
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: AppColors.primary.withOpacity(0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  ),
                  child: Text(l10n.acceptRewards, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
