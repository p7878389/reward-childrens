import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/theme/app_dimens.dart';

class SkeletonCard extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonCard({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = AppDimens.radiusM,
  });

  @override
  State<SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<SkeletonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0.3, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: AppColors.textSecondary.withValues(alpha: _animation.value * 0.1),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        );
      },
    );
  }
}

class SkeletonGrid extends StatelessWidget {
  final int itemCount;
  final double childAspectRatio;
  final int crossAxisCount;
  final double spacing;

  const SkeletonGrid({
    super.key,
    this.itemCount = 6,
    this.childAspectRatio = 1.0,
    this.crossAxisCount = 2,
    this.spacing = AppDimens.paddingM,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const SkeletonCard();
      },
    );
  }
}
