import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/exceptions/app_exceptions.dart';
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';
import 'package:children_rewards/features/exchange/providers/exchange_providers.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';

class RewardDetailScreen extends ConsumerWidget {
  final Reward reward;
  final int? childId;

  const RewardDetailScreen({super.key, required this.reward, this.childId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final childrenAsync = ref.watch(allChildrenStreamProvider);
    
    return childrenAsync.when(
      data: (children) {
        if (children.isEmpty) {
          return _buildScaffold(context, l10n, null);
        }
        final targetChild = childId != null 
            ? children.firstWhere((c) => c.id == childId, orElse: () => children.first)
            : children.first;
        return _buildScaffold(context, l10n, targetChild, ref: ref);
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, _) => Scaffold(body: Center(child: Text('Error: $err'))),
    );
  }

  Widget _buildScaffold(BuildContext context, AppLocalizations l10n, ChildrenData? child, {WidgetRef? ref}) {
    final bool canAfford = child != null && child.stars >= reward.price;
    final bool hasStock = reward.stock == null || reward.stock! > 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderButton(icon: Icons.arrow_back_ios_new_rounded, onTap: () => Navigator.pop(context)),
                  Text(
                    l10n.rewardDetail.toUpperCase(),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1.1),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      // Shorter, More Elegant Image Card
                      SliverToBoxAdapter(
                        child: Container(
                          height: 240,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(color: AppColors.primary.withOpacity(0.08), spreadRadius: 1, blurRadius: 20, offset: const Offset(0, 10)),
                            ],
                          ),
                          child: RepaintBoundary(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: _buildImage(),
                            ),
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Category and Points in one row for balance
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      _getLocalizedCategory(reward.category, l10n).toUpperCase(),
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ),
                                  // Points Badge
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star_rounded, color: Color(0xFFD97706), size: 20),
                                      const SizedBox(width: 4),
                                      Text(
                                        reward.price.toString(),
                                        style: const TextStyle(
                                          fontSize: 20, 
                                          fontWeight: FontWeight.w900, 
                                          color: Color(0xFFD97706),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                reward.name,
                                style: const TextStyle(
                                  fontSize: 22, 
                                  fontWeight: FontWeight.w900, 
                                  color: AppColors.textMain,
                                  height: 1.2,
                                ),
                              ),
                              
                              const SizedBox(height: 32),
                              
                              Text(
                                (reward.description != null && reward.description!.isNotEmpty)
                                    ? reward.description!
                                    : l10n.noDescription,
                                style: TextStyle(
                                  fontSize: 14, 
                                  color: (reward.description != null && reward.description!.isNotEmpty)
                                      ? AppColors.textMain.withOpacity(0.9)
                                      : AppColors.textSecondary.withOpacity(0.5), 
                                  height: 1.6,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: (reward.description != null && reward.description!.isNotEmpty)
                                      ? FontStyle.normal
                                      : FontStyle.italic,
                                ),
                              ),
                              
                              if (reward.stock != null) ...[
                                const SizedBox(height: 32),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black.withOpacity(0.03)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.background,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(Icons.inventory_2_outlined, size: 18, color: AppColors.textSecondary),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            l10n.availableQuantity,
                                            style: TextStyle(fontSize: 11, color: AppColors.textSecondary.withOpacity(0.6), fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            "${reward.stock}",
                                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textMain),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              
                              const SizedBox(height: 120),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Refined Floating Action Button
                  Positioned(
                    left: 40, right: 40, bottom: 24,
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: (canAfford && hasStock) 
                                ? AppColors.primary.withOpacity(0.4)
                                : Colors.black.withOpacity(0.05), 
                            offset: const Offset(0, 8), 
                            blurRadius: 20,
                            spreadRadius: -4,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: (canAfford && hasStock && ref != null)
                            ? () => _handleRedeem(context, ref, l10n, child, reward)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(0xFFE2E8F0),
                          disabledForegroundColor: const Color(0xFF94A3B8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                          elevation: 0,
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          !hasStock ? l10n.outOfStock : (canAfford ? l10n.redeemNow : l10n.needMoreStars),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                        ),
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

  String _getLocalizedCategory(String category, AppLocalizations l10n) {
    switch (category) {
      case 'privileges': return l10n.privileges;
      case 'toys': return l10n.toys;
      case 'snacks': return l10n.snacks;
      default: return l10n.all;
    }
  }

  Widget _buildImage() {
    if (reward.image != null) {
      final file = File(reward.image!);
      if (file.existsSync()) {
        return Image.file(file, fit: BoxFit.cover);
      }
    }
    return const Icon(Icons.card_giftcard_rounded, size: 100, color: Color(0xFFD97706));
  }

  void _handleRedeem(BuildContext context, WidgetRef ref, AppLocalizations l10n, ChildrenData child, Reward reward) async {
    final confirmed = await AppDialogs.showConfirm(
      context: context,
      title: l10n.confirmRedemption,
      message: l10n.confirmRedeemMessage(reward.price, reward.name),
    );

    if (confirmed) {
      try {
        await ref.read(exchangeRepositoryProvider).exchangeReward(
          childId: child.id,
          rewardId: reward.id,
        );
        if (context.mounted) {
          Navigator.pop(context); // Back to store
          AppDialogs.showSuccess(context, l10n.redeemSuccess);
        }
      } on InsufficientFundsException {
        if (context.mounted) {
          AppDialogs.showError(context, l10n.needMoreStars);
        }
      } on OutOfStockException {
        if (context.mounted) {
          AppDialogs.showError(context, l10n.outOfStock);
        }
      } on RewardInactiveException {
        if (context.mounted) {
          AppDialogs.showError(context, 'Reward is no longer available');
        }
      } catch (e, stackTrace) {
        logError('兑换奖励失败', tag: 'RewardDetailScreen', error: e, stackTrace: stackTrace);
        if (context.mounted) {
          AppDialogs.showError(context, 'Error: $e');
        }
      }
    }
  }
}