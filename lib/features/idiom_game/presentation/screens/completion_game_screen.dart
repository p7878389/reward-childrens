import 'dart:async';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_puzzle_entities.dart';
import 'package:children_rewards/features/idiom_game/providers/idiom_game_providers.dart';
import 'package:children_rewards/features/idiom_game/presentation/providers/idiom_puzzle_provider.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/puzzle_game_widgets.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/puzzle_result_dialog.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/idiom_detail_dialog.dart';
import 'package:children_rewards/features/idiom_game/presentation/screens/puzzle_settings_screen.dart';

class CompletionGameScreen extends ConsumerStatefulWidget {
  final int grade;
  final int childId;
  final bool isReviewMode;

  const CompletionGameScreen({
    super.key, 
    required this.grade, 
    required this.childId,
    this.isReviewMode = false,
  });

  @override
  ConsumerState<CompletionGameScreen> createState() => _CompletionGameScreenState();
}

class _CompletionGameScreenState extends ConsumerState<CompletionGameScreen> with TickerProviderStateMixin {
  final Map<int, String> _userInputs = {};
  final Set<int> _usedWordBankIndices = {};
  final Map<int, int> _idiomIndexToWordBankIndex = {};
  
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
      _userInputs.clear();
      _usedWordBankIndices.clear();
      _idiomIndexToWordBankIndex.clear();
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
                mode: IdiomGameMode.completion,
                grade: widget.grade,
                isReviewMode: widget.isReviewMode,
              );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(idiomPuzzleProvider(widget.childId).select((s) => s.currentQuestionIndex), (previous, next) {
      if (previous != next) {
        setState(() {
          _userInputs.clear();
          _usedWordBankIndices.clear();
          _idiomIndexToWordBankIndex.clear();
        });
      }
    });
    
    ref.listen(idiomPuzzleProvider(widget.childId).select((s) => s.idiomToShowDetails), (previous, next) {
      if (next != null) {
        IdiomDetailDialog.show(
          context, 
          idiom: next,
          accentColor: kPrimaryColor,
          autoClose: true,
          badgeText: widget.isReviewMode ? "重点巩固" : "新知识",
        );
        ref.read(idiomPuzzleProvider(widget.childId).notifier).clearIdiomDetails();
      }
    });

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
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close screen
            },
          ),
        );
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

  Widget _buildBody(IdiomPuzzleState state) {
    switch (state.status) {
      case PuzzleGameStatus.ready:
        return _buildReadyState();
      case PuzzleGameStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case PuzzleGameStatus.error:
        if (widget.isReviewMode && state.errorMessage == "没有需要复习的成语") {
          return EmptyState(
            icon: Icons.fact_check_rounded,
            message: "没有需要复习的成语",
            description: "错题已清空，先去挑战新题吧～",
            actionText: "返回大厅",
            onAction: () => Navigator.of(context).pop(),
          );
        }
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
        return _buildReadyState();
      case PuzzleGameStatus.playing:
      case PuzzleGameStatus.roundResult:
        final puzzle = state.currentPuzzle as CompletionPuzzle?;
        if (puzzle == null) return const Center(child: Text("题目加载失败"));
        return _buildPlayingState(puzzle, state);
      default:
        return const Center(child: Text("未知状态"));
    }
  }
  
  Widget _buildReadyState() {
    return Column(
      children: [
        AppHeader(
          title: widget.isReviewMode ? "错题复习" : "准备挑战",
          actions: [
            if (!widget.isReviewMode)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.settings_rounded, color: AppColors.textSecondary),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PuzzleSettingsScreen(childId: widget.childId),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Game Icon with Glow
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withValues(alpha: 0.2),
                        blurRadius: 30,
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: Icon(
                    widget.isReviewMode ? Icons.psychology_outlined : Icons.edit_note_rounded, 
                    size: 80, 
                    color: kPrimaryColor
                  ),
                ),
                const SizedBox(height: 40),
                
                // Mission Card
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
                      Text(
                        widget.isReviewMode ? "专项复习模式" : "成语补全训练",
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black87),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.isReviewMode 
                          ? "针对错题进行专项训练\n连续答对3次即可彻底掌握"
                          : "通过填字游戏巩固成语记忆\n提升词汇量与反应速度",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
                      ),
                      const SizedBox(height: 24),
                      const Divider(height: 1),
                      const SizedBox(height: 24),
                      
                      // Stats Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildReadyStat("类型", widget.isReviewMode ? "错题" : "全库"),
                          _buildReadyStat("目标", widget.isReviewMode ? "消除错题" : "获取星星"),
                          _buildReadyStat("奖励", "双倍经验"),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Tips
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lightbulb_outline_rounded, size: 16, color: Colors.orange[400]),
                    const SizedBox(width: 8),
                    Text(
                      "提示：点击选字区的文字填入空格",
                      style: TextStyle(fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                
                const SizedBox(height: 60),
                
                // Start Button
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: _startCountdownAndGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      foregroundColor: Colors.black87,
                      elevation: 8,
                      shadowColor: kPrimaryColor.withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text(
                      widget.isReviewMode ? "开始复习" : "开启挑战",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2),
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
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.primary)),
      ],
    );
  }

  Widget _buildPlayingState(CompletionPuzzle puzzle, IdiomPuzzleState state) {
    return Column(
      children: [
        AppHeader(
          title: widget.isReviewMode ? "错题复习" : "成语补全",
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
                        valueColor: const AlwaysStoppedAnimation(kPrimaryColor),
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
        
        const Spacer(flex: 1),
        _buildIdiomDisplay(puzzle, state),
        const Spacer(flex: 2),
        _buildWordBank(puzzle, state),
        const SizedBox(height: 48),
      ],
    );
  }

  Widget _buildIdiomDisplay(CompletionPuzzle puzzle, IdiomPuzzleState state) {
    final word = puzzle.idiom.word;
    final hiddenIndices = puzzle.hiddenIndices;
    final isRoundFinished = state.status == PuzzleGameStatus.roundResult;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(word.length, (index) {
        final isHidden = hiddenIndices.contains(index);
        String charToShow = word[index];

        if (isHidden && !isRoundFinished) {
           charToShow = _userInputs[index] ?? ''; 
        }

        Color? overrideColor;
        if (isRoundFinished && isHidden) {
             final userInput = _userInputs[index] ?? '';
             final correctChar = word[index];
             if (userInput == correctChar) {
               overrideColor = kCorrectColor;
             } else {
               overrideColor = kWrongColor;
             }
        }

        return IdiomCharBox(
          char: charToShow,
          isHidden: isHidden,
          isFilled: isHidden && _userInputs.containsKey(index),
          isHighlighted: !isRoundFinished && isHidden && _getFirstEmptyIndex(hiddenIndices) == index,
          textColor: overrideColor,
          onTap: () {
            if (isHidden && _userInputs.containsKey(index) && !isRoundFinished) {
              _handleUnselect(index);
            }
          },
        );
      }),
    );
  }

  void _handleUnselect(int idiomIndex) {
    setState(() {
      final wordBankIndex = _idiomIndexToWordBankIndex.remove(idiomIndex);
      if (wordBankIndex != null) {
        _usedWordBankIndices.remove(wordBankIndex);
      }
      _userInputs.remove(idiomIndex);
    });
  }

  Widget _buildWordBank(CompletionPuzzle puzzle, IdiomPuzzleState state) {
    if (state.status != PuzzleGameStatus.playing) return const SizedBox(height: 200);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: WordBankGrid(
        words: puzzle.wordBank,
        usedIndices: _usedWordBankIndices,
        onWordSelected: (char, wordBankIndex) {
          _handleCharInput(char, wordBankIndex, puzzle);
        },
      ),
    );
  }

  int _getFirstEmptyIndex(List<int> hiddenIndices) {
    for (final index in hiddenIndices) {
      if (!_userInputs.containsKey(index)) return index;
    }
    return -1; 
  }

  void _handleCharInput(String char, int wordBankIndex, CompletionPuzzle puzzle) {
    setState(() {
      final targetIndex = _getFirstEmptyIndex(puzzle.hiddenIndices);
      if (targetIndex != -1) {
        _userInputs[targetIndex] = char;
        _usedWordBankIndices.add(wordBankIndex);
        _idiomIndexToWordBankIndex[targetIndex] = wordBankIndex;

        if (_userInputs.length == puzzle.hiddenIndices.length) {
          _submit(puzzle);
        }
      }
    });
  }

  void _submit(CompletionPuzzle puzzle) {
    final buffer = StringBuffer();
    for (int i = 0; i < puzzle.idiom.word.length; i++) {
      if (puzzle.hiddenIndices.contains(i)) {
        buffer.write(_userInputs[i] ?? '_');
      } else {
        buffer.write(puzzle.idiom.word[i]);
      }
    }
    
    ref.read(idiomPuzzleProvider(widget.childId).notifier).submitCompletionAnswer(buffer.toString());
  }
}
