import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';
import 'package:children_rewards/features/idiom_game/presentation/screens/completion_game_screen.dart';
import 'package:children_rewards/features/idiom_game/presentation/screens/grade_selection_screen.dart';
import 'package:children_rewards/features/idiom_game/providers/idiom_game_providers.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/features/idiom_game/presentation/screens/meaning_game_screen.dart';
import 'package:children_rewards/features/idiom_game/presentation/screens/mistake_book_screen.dart';
import 'package:children_rewards/features/idiom_game/presentation/providers/mistake_book_provider.dart';
import 'package:children_rewards/features/idiom_game/presentation/utils/idiom_resource_guard.dart';

class GameHallScreen extends ConsumerWidget {
  final int childId;

  const GameHallScreen({super.key, required this.childId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final childrenAsync = ref.watch(allChildrenStreamProvider);
    final progressAsync = ref.watch(idiomGradeProgressProvider(childId));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: childrenAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (children) {
            final currentChild = children.firstWhere(
              (c) => c.id == childId,
              orElse: () => children.first,
            );

            return Column(
              children: [
                AppHeader(
                  title: l10n.gameHall,
                  showBack: true,
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // User Info Section (Refined Style)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.textMain.withValues(alpha: 0.04),
                                offset: const Offset(0, 4),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Avatar with StarBadge
                              Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE0F2FE), // Light Blue
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 3),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.textMain.withValues(alpha: 0.1),
                                          offset: const Offset(0, 4),
                                          blurRadius: 12,
                                        ),
                                      ],
                                    ),
                                    child: AvatarImage(
                                      avatar: currentChild.avatar,
                                      fallbackText: currentChild.name,
                                      size: 80,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -2,
                                    right: -4,
                                    child: StarBadge(
                                      count: currentChild.stars,
                                      avatarSize: 80,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              
                              // Info Column
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentChild.name,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.textMain,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        _buildCompactStat(
                                          icon: currentChild.gender == 'boy' ? Icons.male_rounded : Icons.female_rounded,
                                          text: currentChild.gender == 'boy' ? l10n.boy : l10n.girl,
                                          color: currentChild.gender == 'boy' ? Colors.blue : Colors.pink,
                                        ),
                                        const SizedBox(width: 12),
                                        if (currentChild.birthday != null)
                                          _buildCompactStat(
                                            icon: Icons.cake_rounded,
                                            text: l10n.ageYears(_calculateAge(currentChild.birthday!)),
                                            color: AppColors.textSecondary,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Section Title: Main Quest
                        Text(
                          l10n.mainQuest,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textMain,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Featured Game Card (Fixed height for compact layout)
                        SizedBox(
                          height: 110,
                          child: _buildFeaturedGameCard(
                            context,
                            progress: progressAsync.valueOrNull,
                            title: l10n.idiomChainChallenge,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      GradeSelectionScreen(childId: currentChild.id),
                                ),
                              );
                            },
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Section Title: Special Training
                        Text(
                          l10n.specialTraining,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textMain,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Special Training Section
                        Expanded(
                          child: Column(
                            children: [
                              _buildListGameCard(
                                context,
                                title: l10n.idiomCompletion,
                                subtitle: l10n.completeMissingCharacters,
                                icon: Icons.edit_note_rounded,
                                color: const Color(0xFF0EA5E9),
                                onTap: () async {
                                  final ready = await IdiomResourceGuard.ensureIdiomDb(
                                    context: context,
                                    ref: ref,
                                  );
                                  if (!ready || !context.mounted) return;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CompletionGameScreen(grade: 1, childId: currentChild.id),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 12),
                              _buildListGameCard(
                                context,
                                title: l10n.guessIdiomByMeaning,
                                subtitle: l10n.guessIdiomFromMeaning,
                                icon: Icons.psychology_rounded,
                                color: const Color(0xFFF59E0B),
                                onTap: () async {
                                  final ready = await IdiomResourceGuard.ensureIdiomDb(
                                    context: context,
                                    ref: ref,
                                  );
                                  if (!ready || !context.mounted) return;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MeaningGameScreen(
                                        grade: progressAsync.valueOrNull != null ? _getCurrentLevel(progressAsync.value!) : 1,
                                        childId: currentChild.id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 12),
                              Consumer(
                                builder: (context, ref, child) {
                                  final stats = ref.watch(mistakeStatsProvider(currentChild.id));
                                  return _buildListGameCard(
                                    context,
                                    title: l10n.myMistakeBook,
                                    subtitle: l10n.reviewAndLearn,
                                    icon: Icons.auto_stories_rounded,
                                    color: const Color(0xFF8B5CF6),
                                    badgeText: stats.maybeWhen(
                                      data: (s) => s.toReviewCount > 0 ? "${s.toReviewCount}" : null,
                                      orElse: () => null,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => MistakeBookScreen(childId: currentChild.id),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        // Bottom spacing
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeaturedGameCard(BuildContext context, {List<dynamic>? progress, required VoidCallback onTap, required String title}) {
    final int currentLevel = progress != null ? _getCurrentLevel(progress) : 1;
    const int totalLevels = 12;
    final double progressValue = currentLevel / totalLevels;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120, // Reduced height
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(
                Icons.emoji_events_rounded, 
                size: 140,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "Lv.$currentLevel / $totalLevels",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: progressValue,
                                  minHeight: 6,
                                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                                  color: const Color(0xFFFACC15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListGameCard(
    BuildContext context, {
    required String title,
    String? subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    String? badgeText,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 22, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textMain,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (badgeText != null)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4757),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: AppColors.textSecondary.withValues(alpha: 0.2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactStat({
    required IconData icon, 
    required String text, 
    required Color color
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color.withValues(alpha: 0.8)),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textMain.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  int _getCurrentLevel(List<dynamic> progressList) {
    int max = 1;
    for (var p in progressList) {
      if (p.isUnlocked && p.grade > max) max = p.grade;
    }
    return max;
  }

  int _calculateAge(String birthdayStr) {
    try {
      final birthday = DateTime.parse(birthdayStr);
      final today = DateTime.now();
      int age = today.year - birthday.year;
      if (today.month < birthday.month || (today.month == birthday.month && today.day < birthday.day)) {
        age--;
      }
      return age < 0 ? 0 : age;
    } catch (e) {
      return 0;
    }
  }
}
