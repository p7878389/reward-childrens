import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart'; // For AppHeader & CommonFilterTabs
import 'package:children_rewards/features/idiom_game/presentation/screens/game_settings_screen.dart';
import 'package:children_rewards/features/settings/presentation/screens/game_config/daily_limit_config_screen.dart';
import 'package:children_rewards/features/settings/presentation/screens/game_config/puzzle_config/completion_config_screen.dart';
import 'package:children_rewards/features/settings/presentation/screens/game_config/meaning_config/meaning_config_screen.dart';

class GameConfigCenterScreen extends ConsumerStatefulWidget {
  final int childId;

  const GameConfigCenterScreen({super.key, required this.childId});

  @override
  ConsumerState<GameConfigCenterScreen> createState() => _GameConfigCenterScreenState();
}

class _GameConfigCenterScreenState extends ConsumerState<GameConfigCenterScreen> {
  String _selectedTab = 'common';

  final List<FilterTabData> _tabs = const [
    FilterTabData(label: "公共", value: 'common'),
    FilterTabData(label: "接龙", value: 'chain'),
    FilterTabData(label: "补全", value: 'completion'),
    FilterTabData(label: "猜意", value: 'meaning'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppHeader(
            title: "游戏配置中心",
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: CommonFilterTabs(
              tabs: _tabs,
              selectedValue: _selectedTab,
              onSelect: (val) => setState(() => _selectedTab = val),
            ),
          ),

          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedTab) {
      case 'common':
        return DailyLimitConfigScreen(childId: widget.childId);
      case 'chain':
        return GameSettingsScreen(childId: widget.childId, isEmbedded: true);
      case 'completion':
        return PuzzleConfigScreen(childId: widget.childId);
      case 'meaning':
        return MeaningConfigScreen(childId: widget.childId);
      default:
        return const SizedBox.shrink();
    }
  }
}