import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart';
import 'package:children_rewards/features/idiom_game/providers/idiom_game_providers.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';

class IdiomRecommendationScreen extends ConsumerStatefulWidget {
  final int childId;
  final String lastChar;
  final String? lastPinyin;

  const IdiomRecommendationScreen({
    super.key,
    required this.childId,
    required this.lastChar,
    this.lastPinyin,
  });

  @override
  ConsumerState<IdiomRecommendationScreen> createState() => _IdiomRecommendationScreenState();
}

class _IdiomRecommendationScreenState extends ConsumerState<IdiomRecommendationScreen> {
  List<Idiom>? _idioms;
  bool _isLoading = true;
  GameConfig? _config;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final service = ref.read(idiomGameServiceProvider);
    final config = await service.loadGameConfig(widget.childId);
    if (mounted) {
      setState(() => _config = config);
      _loadIdioms(config);
    }
  }

  Future<void> _loadIdioms(GameConfig config) async {
    final service = ref.read(idiomGameServiceProvider);
    final idioms = await service.getCandidateIdioms(
      widget.lastChar,
      includeRare: config.includeRareIdioms,
      matchMode: config.matchMode,
      lastPinyin: widget.lastPinyin,
    );
    if (mounted) {
      setState(() {
        _idioms = idioms;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              title: "推荐成语",
              actions: [
                if (_config != null)
                  _buildModeTag(_config!.matchMode),
              ],
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                  : _idioms == null || _idioms!.isEmpty
                      ? _buildEmptyState()
                      : _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeTag(IdiomMatchMode mode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        mode.displayName,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    String modeDesc;
    if (_config?.matchMode == IdiomMatchMode.homophone) {
      modeDesc = '发音为"${widget.lastPinyin ?? widget.lastChar}"';
    } else if (_config?.matchMode == IdiomMatchMode.contains) {
      modeDesc = '包含"${widget.lastChar}"';
    } else {
      modeDesc = '以"${widget.lastChar}"开头';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            '没有找到$modeDesc的成语',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _idioms!.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final idiom = _idioms![index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    idiom.word,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                  if (idiom.isRare) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "生僻",
                        style: TextStyle(fontSize: 10, color: Colors.orange.shade800),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                idiom.pinyin,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              if (idiom.explanation != null) ...[
                const SizedBox(height: 8),
                Text(
                  idiom.explanation!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
              ],
              if (idiom.source != null) ...[
                const SizedBox(height: 6),
                Text(
                  "出处：${idiom.source}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
