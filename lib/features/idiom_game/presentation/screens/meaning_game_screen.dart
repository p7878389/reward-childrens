import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_puzzle_entities.dart';
import 'package:children_rewards/features/idiom_game/providers/idiom_game_providers.dart';
import 'package:children_rewards/features/idiom_game/presentation/providers/idiom_puzzle_provider.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/puzzle_game_widgets.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/puzzle_result_dialog.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/idiom_detail_dialog.dart';

class MeaningGameScreen extends ConsumerStatefulWidget {
  final int grade;
  final int childId;

  const MeaningGameScreen({super.key, required this.grade, required this.childId});

  @override
  ConsumerState<MeaningGameScreen> createState() => _MeaningGameScreenState();
}

class _MeaningGameScreenState extends ConsumerState<MeaningGameScreen> with TickerProviderStateMixin {
  bool _isCountingDown = false;
  int _countdownValue = 3;
  Timer? _countdownTimer;

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdownAndGame() {
    setState(() {
      _isCountingDown = true;
      _countdownValue = 3;
    });
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_countdownValue > 1) {
          _countdownValue--;
        } else {
          timer.cancel();
          _isCountingDown = false;
          ref.read(idiomPuzzleProvider(widget.childId).notifier).startGame(
                mode: IdiomGameMode.meaning,
                grade: widget.grade,
              );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen for game finish
    ref.listen(idiomPuzzleProvider(widget.childId).select((s) => s.status), (previous, next) {
      if (next == PuzzleGameStatus.finished) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => PuzzleResultDialog(
            state: ref.read(idiomPuzzleProvider(widget.childId)),
            onPlayAgain: () {
              Navigator.of(context).pop();
              _startCountdownAndGame();
            },
            onExit: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        );
      }
    });

    // Listen for idiom details popup
    ref.listen(idiomPuzzleProvider(widget.childId).select((s) => s.idiomToShowDetails), (previous, next) {
      if (next != null) {
        IdiomDetailDialog.show(
          context, 
          idiom: next,
          accentColor: Colors.orange,
          autoClose: true,
          badgeText: "知识回顾",
        );
        ref.read(idiomPuzzleProvider(widget.childId).notifier).clearIdiomDetails();
      }
    });

    final state = ref.watch(idiomPuzzleProvider(widget.childId));

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          SafeArea(child: _buildBody(state)),
          if (_isCountingDown) _buildCountdownOverlay(),
        ],
      ),
    );
  }

  Widget _buildBody(IdiomPuzzleState state) {
    switch (state.status) {
      case PuzzleGameStatus.ready:
        return _buildReadyState();
      case PuzzleGameStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case PuzzleGameStatus.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline_rounded, size: 64, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Text(state.errorMessage ?? 'Error', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("返回"),
              )
            ],
          )
        );
      case PuzzleGameStatus.finished:
        return const SizedBox();
      case PuzzleGameStatus.playing:
      case PuzzleGameStatus.roundResult:
        final puzzle = state.currentPuzzle as MeaningPuzzle?;
        if (puzzle == null) return const Center(child: Text("题目加载失败"));
        return _buildPlayingState(puzzle, state);
      default:
        return const Center(child: Text("未知状态"));
    }
  }

  Widget _buildReadyState() {
    return Column(
      children: [
        const AppHeader(title: "准备挑战"),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                        blurRadius: 30,
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: const Icon(Icons.psychology_rounded, size: 80, color: Color(0xFFF59E0B)),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "看意猜词训练",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black87),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "阅读成语释义，从四个选项中\n选出最符合意思的一个",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
                      ),
                      const SizedBox(height: 24),
                      const Divider(height: 1),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildReadyStat("题目", "10道"),
                          _buildReadyStat("限时", "60秒/题"),
                          _buildReadyStat("等级", "Lv.${widget.grade}"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: _startCountdownAndGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF59E0B),
                      foregroundColor: Colors.white,
                      elevation: 8,
                      shadowColor: const Color(0xFFF59E0B).withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      "开启挑战",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReadyStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFFF59E0B))),
      ],
    );
  }

  Widget _buildPlayingState(MeaningPuzzle puzzle, IdiomPuzzleState state) {
    final bool isRoundFinished = state.status == PuzzleGameStatus.roundResult;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  AppHeader(
                    title: "看意猜词",
                    actions: [
                      TextButton(
                        onPressed: () {
                          ref.read(idiomPuzzleProvider(widget.childId).notifier).skipCurrentQuestion();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[500],
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: const Text("跳过", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: state.totalQuestions > 0 ? (state.currentQuestionIndex + 1) / state.totalQuestions : 0,
                                  backgroundColor: Colors.grey[200],
                                  valueColor: const AlwaysStoppedAnimation(Color(0xFFF59E0B)),
                                  minHeight: 8,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(Icons.timer_outlined, size: 20, color: state.timeLeft < 10 ? kWrongColor : Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              '00:${state.timeLeft.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: state.timeLeft < 10 ? kWrongColor : Colors.grey[700],
                                fontFamily: 'Monospace'
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '第 ${state.currentQuestionIndex + 1}/${state.totalQuestions} 题',
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),

                  // Question Area (Explanation)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.1), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "成语释义",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFD97706),
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Icon(
                                  Icons.format_quote_rounded,
                                  color: const Color(0xFFF59E0B).withValues(alpha: 0.05),
                                  size: 64,
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                child: Text(
                                  puzzle.explanation,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textMain,
                                    height: 1.7,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Options Area
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      key: ValueKey('options_${state.currentQuestionIndex}'),
                      children: List.generate(puzzle.options.length, (index) {
                        final option = puzzle.options[index];
                        return OptionButton(
                          text: option,
                          isSelected: state.selectedOptionIndex == index,
                          isCorrect: index == puzzle.correctIndex,
                          showResult: isRoundFinished,
                          onTap: () {
                            ref.read(idiomPuzzleProvider(widget.childId).notifier).submitMeaningAnswer(index);
                          },
                        );
                      }),
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _buildCountdownOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Text(
            '$_countdownValue',
            key: ValueKey<int>(_countdownValue),
            style: const TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}