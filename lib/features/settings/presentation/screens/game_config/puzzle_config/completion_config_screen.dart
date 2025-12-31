import 'package:children_rewards/features/idiom_game/data/dao/idiom_game_settings_dao.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';
import 'package:children_rewards/shared/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/theme/app_dimens.dart';

class PuzzleConfigScreen extends ConsumerStatefulWidget {
  final int childId;
  const PuzzleConfigScreen({super.key, required this.childId});

  @override
  ConsumerState<PuzzleConfigScreen> createState() => _PuzzleConfigScreenState();
}

class _PuzzleConfigScreenState extends ConsumerState<PuzzleConfigScreen> {
  late IdiomGameSettingsDao _settingsDao;
  bool _isLoading = true;
  int _countdownSeconds = 60;
  int _freeHintsCount = 1;
  bool _includeRareIdioms = false;

  @override
  void initState() {
    super.initState();
    final db = ref.read(databaseProvider);
    _settingsDao = IdiomGameSettingsDao(db);
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await _settingsDao.getSettings(widget.childId);
    if (!mounted) return;
    setState(() {
      _countdownSeconds = settings?.customCountdown ?? 60;
      _freeHintsCount = settings?.customFreeHints ?? 1;
      _includeRareIdioms = settings?.includeRareIdioms ?? false;
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    await _settingsDao.upsertSettings(
      childId: widget.childId,
      customCountdown: _countdownSeconds,
      customFreeHints: _freeHintsCount,
      includeRareIdioms: _includeRareIdioms,
    );
    if (mounted) {
      await AppDialogs.showSuccess(context, '保存成功');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingL, vertical: AppDimens.paddingM),
      children: [
        _buildSectionTitle('难度调整'),
        _buildSettingsCard([
          _buildDropdownTile(
            title: '倒计时时间',
            value: '$_countdownSeconds 秒',
            items: [30, 45, 60, 90, 120],
            currentValue: _countdownSeconds,
            onChanged: (val) => setState(() => _countdownSeconds = val),
            suffix: '秒',
          ),
          _buildDivider(),
          _buildDropdownTile(
            title: '免费提示次数',
            value: '$_freeHintsCount 次',
            items: [0, 1, 2, 3, 5],
            currentValue: _freeHintsCount,
            onChanged: (val) => setState(() => _freeHintsCount = val),
            suffix: '次',
          ),
          _buildDivider(),
          _buildSwitchTile(
            title: '包含生僻成语',
            subtitle: '开启后将包含高难度生僻成语',
            value: _includeRareIdioms,
            onChanged: (value) => setState(() => _includeRareIdioms = value),
          ),
        ]),
        const SizedBox(height: AppDimens.paddingXXL),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _saveSettings,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusM),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            child: const Text('保存设置'),
          ),
        ),
      ],
    );
  }

  // Common UI helpers duplicated for now (can be refactored to shared widgets)
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textMain, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
        boxShadow: [
          BoxShadow(color: AppColors.textMain.withValues(alpha: 0.04), offset: const Offset(0, 8), blurRadius: 24),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({required String title, required String subtitle, required bool value, required ValueChanged<bool> onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingL, vertical: AppDimens.paddingM),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textMain)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(fontSize: 12, color: AppColors.textSecondary.withValues(alpha: 0.7))),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColors.textSecondary.withValues(alpha: 0.1),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile({required String title, required String value, required List<int> items, required int currentValue, required ValueChanged<int> onChanged, required String suffix}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingL, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textMain)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(AppDimens.radiusS)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: currentValue,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: AppColors.textSecondary),
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primary),
                dropdownColor: AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimens.radiusM),
                items: items.map((s) => DropdownMenuItem(value: s, child: Text('$s $suffix'))).toList(),
                onChanged: (v) => onChanged(v!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, indent: 20, endIndent: 20, color: AppColors.textSecondary.withValues(alpha: 0.05));
  }
}
