import 'package:children_rewards/core/database/app_database.dart' show ChildrenData;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/children/presentation/widgets/child_card.dart';
import 'package:children_rewards/features/children/presentation/screens/child_manage_screen.dart';
import 'package:children_rewards/features/children/presentation/screens/add_child_screen.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';
import 'package:children_rewards/shared/widgets/skeleton_loader.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _headerAnimationEnabled = false;

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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return const SizedBox.shrink();
    }

    final childrenAsync = ref.watch(allChildrenStreamProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_headerAnimationEnabled || !mounted) return;
      setState(() {
        _headerAnimationEnabled = true;
      });
    });

    final widget = Scaffold(
      backgroundColor: AppColors.background,
      body: childrenAsync.when(
      data: (children) => _buildDataState(context, l10n, children),
      loading: () => _buildLoadingState(context),
      error: (err, stack) => Center(child: Text('Error: $err')),
    ));
    return widget;
  }

  Widget _buildDataState(
    BuildContext context,
    AppLocalizations l10n,
    List<ChildrenData> children,
  ) {
    final Widget widget;

    if (children.isEmpty) {
      widget = _buildInitialWelcome(context, l10n);
    } else {
      widget = RefreshIndicator(
        onRefresh: () async {
          // StreamProvider updates automatically, but we can fake a delay for UX
          await Future.delayed(const Duration(milliseconds: 500));
        },
        color: AppColors.primary,
        child: RepaintBoundary(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 32,
                      right: 32,
                      top: MediaQuery.paddingOf(context).top + 20,
                      bottom: 40),
                  child: _buildHeader(
                    l10n,
                    enableAnimation: _headerAnimationEnabled,
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
                    childAspectRatio: 1.0,
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
          ),
        ),
      );
    }

    return widget;
  }

  Widget _buildLoadingState(BuildContext context) {
    final widget = CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(
                left: 32,
                right: 32,
                top: MediaQuery.paddingOf(context).top + 20,
                bottom: 40),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonCard(width: 100, height: 16),
                SizedBox(height: 8),
                SkeletonCard(width: 200, height: 32),
              ],
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: SkeletonGrid(itemCount: 4, childAspectRatio: 1.0),
          ),
        ),
      ],
    );
    return widget;
  }

  Widget _buildInitialWelcome(BuildContext context, AppLocalizations l10n) {
    final widget = Container(
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
                  color: AppColors.primary.withValues(alpha: 0.05),
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
                child: Image.asset(
                  'assets/app_icon.png',
                  cacheWidth: 140,
                  cacheHeight: 140,
                ),
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
                shadowColor: AppColors.primary.withValues(alpha: 0.4),
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
    return widget;
  }

  Widget _buildHeader(AppLocalizations l10n, {required bool enableAnimation}) {
    final headerTitle = RichText(
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
    );
    final header = Column(
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
        headerTitle,
      ],
    );

    final Widget widget;
    if (enableAnimation) {
      widget = TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: child,
            ),
          );
        },
        child: header,
      );
    } else {
      widget = header;
    }

    return widget;
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
          color: AppColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: AppColors.textSecondary.withValues(alpha: 0.1),
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
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
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
                color: AppColors.textSecondary.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
