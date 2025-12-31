import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/resource_entities.dart';
import 'package:children_rewards/features/idiom_game/presentation/providers/idiom_game_provider.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/game_result_dialog.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/combo_overlay.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/idiom_detail_dialog.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/game_timer_widget.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/voice_wave_overlay.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/idiom_edit_dialog.dart';
import 'package:children_rewards/features/idiom_game/providers/idiom_game_providers.dart';
import 'package:children_rewards/core/logging/app_logger.dart';
import 'package:children_rewards/core/constants/system_config.dart';
import 'package:path_provider/path_provider.dart';


class IdiomGameScreen extends ConsumerStatefulWidget {
  final int childId;
  final int grade;

  const IdiomGameScreen({super.key, required this.childId, required this.grade});

  @override
  ConsumerState<IdiomGameScreen> createState() => _IdiomGameScreenState();
}

class _IdiomGameScreenState extends ConsumerState<IdiomGameScreen> with TickerProviderStateMixin {
  StreamSubscription? _speechTextSubscription;
  StreamSubscription? _partialTextSubscription; // 中间结果订阅
  bool _isListening = false;
  bool _isCanceling = false;
  bool _isEngineLoading = true; // 默认正在加载引擎
  bool _isWaitingForResult = false; // 等待最终结果
  String _currentSpeechText = "";
  String _finalResultBuffer = ""; // Buffer for final results
  String _loadingStep = "正在准备语音引擎...";
  bool _isExiting = false;
  final GlobalKey<ComboOverlayState> _comboKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  Future<void> _initializeGame() async {
    final speechService = ref.read(speechRecognitionServiceProvider);
    
    // 如果引擎已经加载完成，直接进入游戏
    if (speechService.isInitialized) {
      setState(() {
        _isEngineLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _startNewGameSession();
      });
      return;
    }

    try {
      setState(() => _loadingStep = "正在请求权限...");
      // ... (权限逻辑保持不变)
      final micStatus = await Permission.microphone.request();
      if (!mounted) return;

      if (!micStatus.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('需要麦克风权限才能使用语音输入')),
        );
      }

      await Permission.speech.request();
      if (!mounted) return;

      setState(() => _loadingStep = "正在准备语音引擎...");
      final resourceService = ref.read(resourceDownloadServiceProvider);
      await resourceService.startDownload(ResourceType.voskModel);
      if (!mounted) return;

      setState(() => _loadingStep = "正在载入本地模型...");
      final ttsService = ref.read(ttsServiceProvider);
      final appDir = await getApplicationDocumentsDirectory();
      final modelPath = '${appDir.path}/$kVoskModelDirName';

      await speechService.initialize(modelPath);
      await ttsService.initialize();
      if (!mounted) return;

      setState(() {
        _isEngineLoading = false;
      });

      _startNewGameSession();
    } catch (e) {
      logger.error("IdiomGameScreen", "Initialization error: $e");
      if (mounted) {
        setState(() => _loadingStep = "加载失败，请重试");
      }
    }
  }

  /// 启动/重置一个新的游戏对局
  void _startNewGameSession() {
    // 重置页面本地 UI 状态
    setState(() {
      _currentSpeechText = "";
      _isListening = false;
      _isCanceling = false;
      _isWaitingForResult = false;
    });

    // 启动游戏逻辑
    ref.read(idiomGameProvider(widget.childId).notifier).startGame(widget.grade);

    // 重新订阅语音流（确保旧订阅已取消）
    _speechTextSubscription?.cancel();
    _partialTextSubscription?.cancel();

    final speechService = ref.read(speechRecognitionServiceProvider);

    // 订阅中间结果流 - (根据需求：不要边说边识别，因此忽略中间结果展示)
    _partialTextSubscription = speechService.partialTextStream.listen((partialText) {
      // 仅记录日志，不更新 UI，不执行提前提交
      // logger.debug("IdiomGameScreen", "Partial: $partialText");
    });

    // 订阅最终结果流 - 累积结果，等待松手后提交
    _speechTextSubscription = speechService.textStream.listen((text) {
      if (!mounted || text.isEmpty || _isCanceling) return;

      logger.info("IdiomGameScreen", "收到最终结果片段: $text");
      _finalResultBuffer += text; // Append result
      
      // 如果处于"等待结果"状态（已松手），且收到了结果，尝试提交
      // 注意：Vosk stop() 后可能会触发这里，也可能不触发，逻辑在 _onListeningEnd 处理
    });
  }



  /// 处理最终结果（兜底逻辑）
  void _handleFinalResult(String text) async {
    setState(() {
      _isWaitingForResult = false;
      _isListening = false;
    });

    if (text.isEmpty) {
      // 没识别到内容，显示编辑框让用户输入
      _showEditDialog("");
      return;
    }

    // 智能确认：如果识别结果是一个有效成语，直接提交，不再弹窗
    final isCandidateValid = await ref.read(idiomGameProvider(widget.childId).notifier).checkIdiomCandidate(text);
    
    if (isCandidateValid) {
      logger.info("IdiomGameScreen", "智能确认：识别结果 '$text' 有效，直接提交");
      if (mounted) {
        ref.read(idiomGameProvider(widget.childId).notifier).submitIdiom(text);
        setState(() {
          _currentSpeechText = "";
        });
      }
    } else {
      logger.info("IdiomGameScreen", "智能确认：识别结果 '$text' 无效或不确定，显示编辑框");
      if (mounted) {
        _showEditDialog(text);
      }
    }
  }

  Future<void> _showEditDialog(String initialText) async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => IdiomEditDialog(initialText: initialText),
    );

    if (mounted) {
      if (result != null && result.isNotEmpty) {
        ref.read(idiomGameProvider(widget.childId).notifier).submitIdiom(result);
      } else {
        ref.read(idiomGameProvider(widget.childId).notifier).resumeTimer();
      }
    }
    
    setState(() {
      _currentSpeechText = "";
    });
  }

  @override
  void dispose() {
    _speechTextSubscription?.cancel();
    _partialTextSubscription?.cancel();
    super.dispose();
  }

  void _onListeningStart() async {
    // 先停止 TTS，避免与语音识别冲突
    await ref.read(ttsServiceProvider).stop();

    // 暂停倒计时
    ref.read(idiomGameProvider(widget.childId).notifier).pauseTimer();

    setState(() {
      _isListening = true;
      _isCanceling = false;
      _isWaitingForResult = false;
      _currentSpeechText = "";
      _finalResultBuffer = ""; // Clear buffer
    });
    ref.read(speechRecognitionServiceProvider).startListening();
  }

  void _onListeningEnd() {
    if (!_isListening) return;

    if (_isCanceling) {
      // 取消操作
      ref.read(speechRecognitionServiceProvider).cancel();
      ref.read(idiomGameProvider(widget.childId).notifier).resumeTimer();
      setState(() {
        _isListening = false;
        _isCanceling = false;
        _isWaitingForResult = false;
        _currentSpeechText = "";
        _finalResultBuffer = "";
      });
    } else {
      // 正常松开：停止录音，等待最终结果
      logger.info("IdiomGameScreen", "松开手指，停止录音，等待识别结果...");
      
      setState(() {
        _isListening = false; // 停止波纹
        _isWaitingForResult = true; // 显示加载/等待状态
      });

      // 停止引擎，这通常会触发最后一次 textStream 事件
      ref.read(speechRecognitionServiceProvider).stopListening();

      // 延迟一点时间，确保 buffer 收集到最后的结果
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted || !_isWaitingForResult) return;

        final result = _finalResultBuffer.replaceAll(' ', '').trim();
        logger.info("IdiomGameScreen", "提交最终识别结果: \"$result\"");

        if (result.isNotEmpty) {
          _handleFinalResult(result);
        } else {
          // 没识别到内容
          logger.warning("IdiomGameScreen", "未识别到内容");
          _handleFinalResult(""); // 提交空字符串或提示用户
          // 或者恢复倒计时
          // ref.read(idiomGameProvider(widget.childId).notifier).resumeTimer();
        }
      });
    }
  }

  void _onDragUpdate(LongPressMoveUpdateDetails details) {
    if (details.localOffsetFromOrigin.dy < -50) {
      if (!_isCanceling) {
        setState(() {
          _isCanceling = true;
        });
      }
    } else {
      if (_isCanceling) {
        setState(() {
          _isCanceling = false;
        });
      }
    }
  }

  void _showHintDialog(BuildContext context, List<String> hints) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        backgroundColor: Colors.white,
        elevation: 24,
        child: Container(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFFFEF3C7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lightbulb_rounded, size: 32, color: Color(0xFFD97706)),
              ),
              const SizedBox(height: 20),
              Text(
                hints.isNotEmpty ? "试试这些成语" : "暂无提示",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textMain),
              ),
              const SizedBox(height: 24),
              if (hints.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "这个词太难了，连提示君都不知道...\n(可以尝试认输或换个词接)",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ),
                )
              else
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: hints.map((hint) => ActionChip(
                    label: Text(hint, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.amber.withValues(alpha: 0.1),
                    labelStyle: const TextStyle(color: Color(0xFFD97706)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.amber.withValues(alpha: 0.3)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )).toList(),
                ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF59E0B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    "我知道了",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.red.shade100, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
              ),
              const SizedBox(height: 16),
              const Text(
                "哎呀！",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700, height: 1.5),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("我知道了", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmExit(BuildContext context) async {
    final gameState = ref.read(idiomGameProvider(widget.childId));
    
    // 如果不在游戏中，直接允许退出
    if (gameState.status != GameStatus.playing) return true;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text("正在对局中", style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text("现在退出将放弃本次挑战，确定吗？"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("继续对局", style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("退出", style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // 执行退出前的业务流程
      _isExiting = true;
      if (_isListening) {
        ref.read(speechRecognitionServiceProvider).cancel();
      }
      ref.read(idiomGameProvider(widget.childId).notifier).giveUp(); // 标记对局结束
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final gameNotifier = ref.read(idiomGameProvider(widget.childId).notifier);
    // 使用 select 只监听 status 和 chain，避免 remainingTime 每秒变化触发整个界面重建
    final gameStatus = ref.watch(idiomGameProvider(widget.childId).select((s) => s.status));
    final gameChain = ref.watch(idiomGameProvider(widget.childId).select((s) => s.chain));
    // 用于传递给子方法的完整状态（不触发重建，仅在 status/chain 变化时读取最新值）
    final gameState = ref.read(idiomGameProvider(widget.childId));
    
    // Listen for state changes
    ref.listen<IdiomGameState>(idiomGameProvider(widget.childId), (previous, next) {
      // Game Over
      if (next.status == GameStatus.gameOver) {
        if (_isExiting) return;

        // Ensure listening overlay is closed if game ends unexpectedly
        if (_isListening) {
          setState(() {
            _isListening = false;
            _isCanceling = false;
          });
          ref.read(speechRecognitionServiceProvider).stopListening();
        }

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => GameResultDialog(
            gameState: next,
            childId: widget.childId,
            onPlayAgain: () {
              Navigator.of(context).pop(); // Close Dialog
              _startNewGameSession();      // Optimized: Only reset game, no engine reload
            },
          ),
        );
      }
      
      // AI Speech
      if (previous?.chain.length != next.chain.length && next.chain.isNotEmpty && next.chain.last.player == PlayerType.ai) {
        ref.read(ttsServiceProvider).speak(next.chain.last.word);
      }
      
      // Error Handling (Large Dialog)
      if (next.error != null && next.error != previous?.error) {
        _showErrorDialog(context, next.error.toString());
      }

      // Countdown Sound Effect
      if (next.remainingTime <= 5 && next.remainingTime > 0 && next.remainingTime != previous?.remainingTime) {
         ref.read(ttsServiceProvider).speak(next.remainingTime.toString());
      }

      // Hint Display
      if (next.currentHints != null && next.currentHints != previous?.currentHints) {
        _showHintDialog(context, next.currentHints!);
      }

      // Combo & Speed Effects
      if (previous != null) {
        if (next.combo > previous.combo && next.combo > 1) {
          _comboKey.currentState?.showCombo(next.combo);
        }
        if (next.fastAnswerCount > previous.fastAnswerCount) {
          _comboKey.currentState?.showSpeedBonus();
        }
        if (next.isAiSurrender && !previous.isAiSurrender) {
          _comboKey.currentState?.showAiSurrender();
        }
      }
    });

    if (_isEngineLoading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: AppColors.primary),
              const SizedBox(height: 24),
              Text(
                _loadingStep,
                style: const TextStyle(
                  color: AppColors.textMain,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "离线引擎首次加载可能需要几秒钟",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    bool isPlayerTurn = gameStatus == GameStatus.playing &&
                        (gameChain.isEmpty || gameChain.last.player == PlayerType.ai);

    return PopScope(
      canPop: false, // 拦截物理返回和手势返回
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _confirmExit(context);
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Prevent background resize when keyboard opens for dialog
        body: Stack(
          children: [
            // Main Background
            Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // Optimized Top Bar (Merged Header & Status)
                    _buildGameTopBar(context, theme, gameState, isPlayerTurn, gameNotifier),
                    
                    // Real-time Recognized Text (Floating Draft)
                    if (_currentSpeechText.isNotEmpty && gameStatus == GameStatus.playing)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.record_voice_over_rounded, size: 16, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Text(
                              _currentSpeechText,
                              style: const TextStyle(
                                fontSize: 16, 
                                fontWeight: FontWeight.bold, 
                                color: AppColors.textMain
                              ),
                            ),
                          ],
                        ),
                      ),

                    Expanded(
                      child: _buildIdiomChainArea(l10n, gameChain),
                    ),
                    
                    // Optimized Bottom Controls
                    _buildMinimalControlDeck(theme, gameState, gameNotifier, isPlayerTurn),
                  ],
                ),
              ),
            ),
            
            // Full screen wave overlay when listening
            if (_isListening)
              Positioned.fill(
                child: VoiceWaveOverlay(
                  isCanceling: _isCanceling,
                  currentText: _currentSpeechText,
                ),
              ),
            
            // Effects Overlay
            ComboOverlay(key: _comboKey),
          ],
        ),
      ),
    );
  }

  Widget _buildGameTopBar(BuildContext context, ThemeData theme, IdiomGameState state, bool isPlayerTurn, IdiomGameNotifier notifier) {
    // Determine AI Status Text
    String statusText;
    Color statusColor;
    if (state.isAiSurrender) {
      statusText = "AI 已认输";
      statusColor = Colors.purple;
    } else if (isPlayerTurn) {
      statusText = "轮到你了";
      statusColor = AppColors.textMain;
    } else {
      statusText = "AI 思考中...";
      statusColor = theme.colorScheme.primary;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          // Back Button
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () async {
                if (await _confirmExit(context)) {
                  if (context.mounted) Navigator.of(context).pop();
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.textMain),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Center Status Pill
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isPlayerTurn ? AppColors.primary.withValues(alpha: 0.1) : theme.colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: isPlayerTurn 
                        ? const Icon(Icons.person_rounded, size: 20, color: AppColors.primary)
                        : Icon(Icons.smart_toy_rounded, size: 20, color: theme.colorScheme.primary),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Text
                  Expanded(
                    child: Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Grade Info (Small)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Lv.${widget.grade}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ),
          
          const SizedBox(width: 12),

          // Timer Circle - 使用独立组件避免整个界面重建
          GameTimerWidget(
            childId: widget.childId,
            maxSeconds: 60,
          ),

          const SizedBox(width: 8),
          
          // Menu/GiveUp Button (Small)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isPlayerTurn ? () => _confirmGiveUp(context, notifier) : null,
              borderRadius: BorderRadius.circular(20),
              child: Opacity(
                opacity: isPlayerTurn ? 1.0 : 0.3,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.flag_outlined, size: 24, color: AppColors.textSecondary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdiomChainArea(AppLocalizations l10n, List<IdiomChainLink> chain) {
    if (chain.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              "游戏开始！\n请等待 AI 出题...",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    final reversedChain = chain.reversed.toList();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      reverse: true,
      itemCount: reversedChain.length,
      itemBuilder: (context, index) {
        final link = reversedChain[index];
        final isLast = index == 0;
        return _buildIdiomBubble(link, isLast);
      },
    );
  }

  Widget _buildIdiomBubble(IdiomChainLink link, bool isLast) {
    final isAi = link.player == PlayerType.ai;
    return Align(
      alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          // Construct Idiom object from Link to show details
          final idiom = Idiom(
            id: link.idiomId ?? 0,
            word: link.word,
            pinyin: link.pinyin,
            firstPinyinNoTone: '', // Not needed for display
            lastPinyinNoTone: '',
            firstChar: '',
            lastChar: '',
            explanation: link.explanation,
            source: link.source,
            isRare: link.isRare,
          );
          
          IdiomDetailDialog.show(
            context, 
            idiom: idiom,
            accentColor: isAi ? const Color(0xFF6C63FF) : AppColors.primary,
            badgeText: isAi ? "AI 出题" : "你的回答",
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            crossAxisAlignment: isAi ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isAi ? Colors.white : const Color(0xFF6C63FF),
                  gradient: !isAi 
                      ? const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF5A52E0)]) 
                      : null,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: isAi ? Radius.zero : const Radius.circular(20),
                    bottomRight: isAi ? const Radius.circular(20) : Radius.zero,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        link.word,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: isAi ? Colors.black87 : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        link.pinyin,
                        style: TextStyle(
                          color: isAi ? Colors.grey.shade600 : Colors.white.withValues(alpha: 0.8),
                          fontSize: 14,
                        ),
                      ),
                      if (link.explanation != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isAi ? Colors.grey.shade50 : Colors.black.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                link.explanation!,
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.4,
                                  color: isAi ? Colors.grey.shade800 : Colors.white.withValues(alpha: 0.9),
                                ),
                              ),
                              if (link.source != null) ...[
                                const SizedBox(height: 6),
                                Text(
                                  "出处：${link.source}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontStyle: FontStyle.italic,
                                    color: isAi ? Colors.grey.shade500 : Colors.white.withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (isLast)
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                  child: Text(
                    isAi ? "刚刚" : "你",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinimalControlDeck(ThemeData theme, IdiomGameState state, IdiomGameNotifier notifier, bool isPlayerTurn) {

    if (state.status == GameStatus.gameOver) {
      // Keep Game Over View Simple
      return Container(
        padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).padding.bottom + 16),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () => _startNewGameSession(),
            icon: const Icon(Icons.replay_rounded),
            label: const Text("再来一局", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textMain,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, MediaQuery.of(context).padding.bottom + 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Hint Button (Small Circle)
          _buildCircleActionButton(
            icon: Icons.lightbulb_outline_rounded,
            badgeCount: state.freeHints,
            onPressed: (isPlayerTurn && state.freeHints > 0) ? notifier.getHint : null,
            color: const Color(0xFFF59E0B),
            size: 48,
          ),
          
          const Spacer(),
          
          // Main Voice Button
          GestureDetector(
            onLongPressStart: isPlayerTurn ? (_) => _onListeningStart() : null,
            onLongPressMoveUpdate: isPlayerTurn ? _onDragUpdate : null,
            onLongPressEnd: isPlayerTurn ? (_) => _onListeningEnd() : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isPlayerTurn 
                  ? (_isListening ? const Color(0xFFEF4444) : AppColors.primary)
                  : Colors.grey.shade200,
                shape: BoxShape.circle,
                boxShadow: [
                  if (isPlayerTurn)
                    BoxShadow(
                      color: (_isListening ? const Color(0xFFEF4444) : AppColors.primary).withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                ],
              ),
              child: Icon(
                _isListening ? Icons.more_horiz_rounded : Icons.mic_rounded,
                size: 36,
                color: isPlayerTurn ? AppColors.textMain : Colors.grey.shade400,
              ),
            ),
          ),
          
          const Spacer(),
          
          // Placeholder for symmetry (or future feature)
          const SizedBox(width: 48), 
        ],
      ),
    );
  }

  Widget _buildCircleActionButton({
    required IconData icon, 
    required int badgeCount,
    VoidCallback? onPressed, 
    required Color color,
    required double size,
  }) {
    final isEnabled = onPressed != null;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size / 2),
          elevation: isEnabled ? 2 : 0,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(size / 2),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size / 2),
                border: Border.all(
                  color: isEnabled ? Colors.transparent : Colors.grey.shade200,
                ),
              ),
              child: Icon(
                icon,
                size: 24,
                color: isEnabled ? color : Colors.grey.shade300,
              ),
            ),
          ),
        ),
        if (badgeCount > 0)
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.background, width: 2),
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Center(
                child: Text(
                  "$badgeCount",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _confirmGiveUp(BuildContext context, IdiomGameNotifier notifier) async {
     final confirmed = await showDialog<bool>(
       context: context,
       builder: (context) => AlertDialog(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
         title: const Text("要认输吗？", style: TextStyle(fontWeight: FontWeight.bold)),
         content: const Text("认输将结束当前对局。"),
         actions: [
           TextButton(
             onPressed: () => Navigator.pop(context, false),
             child: const Text("继续挑战", style: TextStyle(color: AppColors.textSecondary)),
           ),
           TextButton(
             onPressed: () => Navigator.pop(context, true),
             child: const Text("确认认输", style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.bold)),
           ),
         ],
       ),
     );
     if (confirmed == true) {
       notifier.giveUp();
     }
  }
}
