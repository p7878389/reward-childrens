import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/children/presentation/widgets/child_card.dart';
import 'package:children_rewards/features/children/presentation/screens/child_manage_screen.dart';
import 'package:children_rewards/features/children/presentation/screens/add_child_screen.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  /// 根据当前时间获取问候语
  String _getGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return l10n.goodMorning;
    } else if (hour >= 12 && hour < 18) {
      return l10n.goodAfternoon;
    } else {
      return l10n.goodEvening;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return const SizedBox.shrink();

    final childrenAsync = ref.watch(allChildrenStreamProvider);

    return childrenAsync.when(
      data: (children) {
        if (children.isEmpty) {
          return _buildInitialWelcome(context, l10n);
        }

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 60, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getGreeting(l10n),
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textMain,
                          height: 1.3,
                        ),
                        children: [
                          TextSpan(text: '${l10n.whoIsEarning}\n'),
                          TextSpan(
                            text: l10n.stars.toLowerCase(),
                            style: const TextStyle(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.wavy,
                              decorationColor: AppColors.primary,
                            ),
                          ),
                          TextSpan(text: ' ${l10n.todayQuestion}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < children.length) {
                      final childData = children[index];
                      return ChildCard(
                        child: childData,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChildManageScreen(child: childData),
                            ),
                          );
                        },
                      );
                    } else {
                      return _buildAddCard(context, l10n);
                    }
                  },
                  childCount: children.length + 1,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildInitialWelcome(BuildContext context, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Exquisite Hero Illustration
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(0, 10)),
                  ],
                ),
                padding: const EdgeInsets.all(30),
                child: Image.asset('assets/app_icon.png'),
              ),
            ],
          ),
          const SizedBox(height: 48),

          Text(
            l10n.welcomeTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.textMain,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 64),

          // Primary Action
          SizedBox(
            width: double.infinity,
            height: 64,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddChildScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 8,
                shadowColor: AppColors.primary.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_rounded, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    l10n.createProfile,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCard(BuildContext context, AppLocalizations l10n) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddChildScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: AppColors.textSecondary.withOpacity(0.1),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: const Icon(Icons.add_rounded,
                  color: AppColors.primary, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.addAnotherChild,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
