import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart' as domain;
import 'package:children_rewards/features/idiom_game/presentation/providers/mistake_book_provider.dart';
import 'package:children_rewards/features/idiom_game/presentation/screens/completion_game_screen.dart';
import 'package:children_rewards/features/idiom_game/presentation/widgets/puzzle_game_widgets.dart'; 
import 'package:children_rewards/features/idiom_game/presentation/widgets/idiom_detail_dialog.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_engagement_dao.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MistakeBookScreen extends ConsumerStatefulWidget {
  final int childId;

  const MistakeBookScreen({super.key, required this.childId});

  @override
  ConsumerState<MistakeBookScreen> createState() => _MistakeBookScreenState();
}

class _MistakeBookScreenState extends ConsumerState<MistakeBookScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(mistakeListProvider(widget.childId).notifier).loadMore();
    }
  }

  Future<void> _refresh() async {
    ref.invalidate(mistakeStatsProvider(widget.childId));
    await ref.read(mistakeListProvider(widget.childId).notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(mistakeStatsProvider(widget.childId));
    final listState = ref.watch(mistakeListProvider(widget.childId));

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          const AppHeader(title: "我的错题本"),
          
          // Stats Summary Area
          statsAsync.when(
            data: (stats) => _buildSummaryCard(stats),
            loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator())),
            error: (e, _) => const SizedBox(),
          ),

          // List Area
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              color: kPrimaryColor,
              child: listState.items.isEmpty && !listState.isLoading
                ? _buildEmptyState()
                : _buildMistakeList(listState),
            ),
          ),
        ],
      ),
      bottomNavigationBar: listState.items.any((e) => e.record.masteryLevel < 3)
          ? _buildBottomAction(context)
          : null,
    );
  }

  Widget _buildSummaryCard(MistakeStats stats) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            _buildStatItem("待复习", stats.toReviewCount.toString(), Colors.orange),
            Container(width: 1, height: 30, color: Colors.grey[100]),
            _buildStatItem("已掌握", stats.masteredCount.toString(), kCorrectColor),
            Container(width: 1, height: 30, color: Colors.grey[100]),
            _buildStatItem("总收录", stats.totalMistakes.toString(), Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: color)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_stories_outlined, size: 80, color: Colors.grey[200]),
              const SizedBox(height: 16),
              Text("错题本还是空的哦", style: TextStyle(color: Colors.grey[400], fontSize: 16)),
              const SizedBox(height: 8),
              Text("在游戏中遇到困难会自动收录到这里", style: TextStyle(color: Colors.grey[300], fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMistakeList(MistakeListState listState) {
    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: listState.items.length + (listState.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == listState.items.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final item = listState.items[index];
        
        // Map Drift Idiom to Domain Idiom
        final domainIdiom = domain.Idiom(
          id: item.idiom.id,
          word: item.idiom.word,
          pinyin: item.idiom.pinyin,
          firstPinyinNoTone: item.idiom.firstPinyinNoTone,
          lastPinyinNoTone: item.idiom.lastPinyinNoTone,
          firstPinyin: item.idiom.firstPinyin,
          lastPinyin: item.idiom.lastPinyin,
          firstChar: item.idiom.firstChar,
          lastChar: item.idiom.lastChar,
          explanation: item.idiom.explanation,
          source: item.idiom.source,
          isRare: item.idiom.isRare,
        );

        return InkWell(
          onTap: () {
            IdiomDetailDialog.show(
              context, 
              idiom: domainIdiom,
              accentColor: const Color(0xFF8B5CF6), // Use purple from Mistake Book theme
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: _buildMistakeCard(item),
        );
      },
    );
  }

  Widget _buildMistakeCard(MistakeDetail item) {
    final record = item.record;
    final idiom = item.idiom;
    
    Color statusColor;
    String statusText;
    switch (record.masteryLevel) {
      case 0:
        statusColor = Colors.red[400]!;
        statusText = "未掌握";
        break;
      case 1:
        statusColor = Colors.orange[400]!;
        statusText = "初识";
        break;
      case 2:
        statusColor = Colors.blue[400]!;
        statusText = "熟悉";
        break;
      case 3:
      default:
        statusColor = kCorrectColor;
        statusText = "掌握";
        break;
    }

    final lastWrongStr = record.lastWrongAt != null 
        ? DateFormat('MM-dd').format(record.lastWrongAt!)
        : '从未';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: record.masteryLevel == 3 ? Colors.transparent : statusColor.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  idiom.word,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  idiom.pinyin,
                  style: TextStyle(fontSize: 13, color: Colors.grey[500], fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildMiniTag("❌ ${record.failCount}", Colors.grey[100]!, Colors.grey[600]!),
                    const SizedBox(width: 8),
                    _buildMiniTag("✓ ${record.correctCount}", Colors.grey[100]!, Colors.grey[600]!),
                    const SizedBox(width: 8),
                    Text("最近错误：$lastWrongStr", style: TextStyle(fontSize: 11, color: Colors.grey[400])),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor),
                ),
              ),
              const SizedBox(height: 8),
              // Show progress dots
              Row(
                children: List.generate(3, (i) => Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i < record.masteryLevel ? statusColor : Colors.grey[100],
                  ),
                )),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniTag(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: fg)),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5))
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: () => _startReview(context),
          icon: const Icon(Icons.psychology_outlined),
          label: const Text("开始专项复习", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.black87,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
        ),
      ),
    );
  }

  void _startReview(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CompletionGameScreen(
          grade: 1, 
          childId: widget.childId,
          isReviewMode: true,
        ),
      ),
    ).then((_) {
      _refresh();
    });
  }
}
