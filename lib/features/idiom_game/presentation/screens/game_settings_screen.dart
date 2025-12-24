import 'package:children_rewards/shared/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_game_settings_dao.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/theme/app_dimens.dart';
import 'package:children_rewards/shared/widgets/app_header.dart';

/// 游戏设置界面
class GameSettingsScreen extends ConsumerStatefulWidget {
  final int childId;

  const GameSettingsScreen({super.key, required this.childId});

  @override
  ConsumerState<GameSettingsScreen> createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends ConsumerState<GameSettingsScreen> {
  late IdiomGameSettingsDao _settingsDao;
  bool _isLoading = true;

  // 临时配置状态
  int _countdownSeconds = 15;
  int _freeHintsCount = 1;
  IdiomMatchMode _matchMode = IdiomMatchMode.exact;
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
    setState(() {
      _countdownSeconds = settings?.customCountdown ?? 15;
      _freeHintsCount = settings?.customFreeHints ?? 1;
      _matchMode = IdiomMatchMode.fromValue(settings?.matchMode ?? 0);
      _includeRareIdioms = settings?.includeRareIdioms ?? false;
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    await _settingsDao.upsertSettings(
      childId: widget.childId,
      customCountdown: _countdownSeconds,
      customFreeHints: _freeHintsCount,
      matchMode: _matchMode.value,
      includeRareIdioms: _includeRareIdioms,
    );

    if (mounted) {
      // final l10n = AppLocalizations.of(context)!; // Removed as we use custom text now
      await AppDialogs.showSuccess(context, '保存成功');
      if (mounted) {
        Navigator.pop(context, true); // 返回 true 表示配置已更新
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppHeader(title: '接龙设置'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingL, vertical: AppDimens.paddingM),
              physics: const BouncingScrollPhysics(),
              children: [
                _buildSectionTitle('接龙规则'),
                _buildMatchModeCard(),

                const SizedBox(height: AppDimens.paddingXL),

                _buildSectionTitle('难度调整'),
                _buildSettingsCard([
                  _buildDropdownTile(
                    title: '倒计时时间',
                    value: '$_countdownSeconds',
                    items: [5, 8, 10, 15, 20, 30],
                    currentValue: _countdownSeconds,
                    onChanged: (val) => setState(() => _countdownSeconds = val),
                    suffix: '',
                  ),
                  _buildDivider(),
                  _buildDropdownTile(
                    title: '免费提示次数',
                    value: '$_freeHintsCount',
                    items: [0, 1, 2, 3, 5],
                    currentValue: _freeHintsCount,
                    onChanged: (val) => setState(() => _freeHintsCount = val),
                    suffix: '',
                  ),
                ]),

                const SizedBox(height: AppDimens.paddingL),

                _buildSectionTitle('其他选项'),
                _buildSettingsCard([
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
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w800, 
                        fontSize: 16,
                      ),
                    ),
                    child: const Text('保存设置'),
                  ),
                ),
                const SizedBox(height: AppDimens.paddingXXL),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: AppColors.textMain,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildMatchModeCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.textMain.withValues(alpha: 0.04),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < IdiomMatchMode.values.length; i++) ...[
            if (i > 0) _buildDivider(),
            _buildMatchModeOption(IdiomMatchMode.values[i]),
          ],
        ],
      ),
    );
  }

  Widget _buildMatchModeOption(IdiomMatchMode mode) {
    final isSelected = _matchMode == mode;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _matchMode = mode),
        borderRadius: BorderRadius.vertical(
          top: mode == IdiomMatchMode.values.first ? const Radius.circular(AppDimens.radiusL) : Radius.zero,
          bottom: mode == IdiomMatchMode.values.last ? const Radius.circular(AppDimens.radiusL) : Radius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingL),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          mode.displayName,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                            color: isSelected ? AppColors.primary : AppColors.textMain,
                          ),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              '推荐',
                              style: TextStyle(
                                fontSize: 10, 
                                color: AppColors.primary, 
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      mode.description,
                      style: TextStyle(
                        fontSize: 13, 
                        color: AppColors.textSecondary.withValues(alpha: 0.8),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildExampleBox(mode, isSelected),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Container(
                        margin: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleBox(IdiomMatchMode mode, bool isSelected) {
    final parts = mode.example.split(' → ');
    String first = mode.example;
    String? second;
    String? extra;

    if (parts.length == 2) {
      first = parts[0];
      if (parts[1].contains('（')) {
        final subParts = parts[1].split('（');
        second = subParts[0];
        extra = '（${subParts[1]}';
      } else {
        second = parts[1];
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected 
            ? AppColors.primary.withValues(alpha: 0.05) 
            : AppColors.textSecondary.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppDimens.radiusS),
        border: Border.all(
          color: isSelected 
              ? AppColors.primary.withValues(alpha: 0.1) 
              : AppColors.textSecondary.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '💡 示例：',
                style: TextStyle(
                  fontSize: 11, 
                  fontWeight: FontWeight.w800, 
                  color: AppColors.primary,
                ),
              ),
              if (second != null) ...[
                _buildIdiomText(first, isSelected),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.arrow_forward_rounded, 
                    size: 12, 
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
                _buildIdiomText(second, isSelected),
                if (extra != null) 
                  Text(
                    extra,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ] else 
                _buildIdiomText(first, isSelected),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIdiomText(String text, bool isSelected) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: isSelected ? AppColors.textMain : AppColors.textMain.withValues(alpha: 0.7),
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.textMain.withValues(alpha: 0.04),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingL, vertical: AppDimens.paddingM),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                  ),
                ),
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

  Widget _buildDropdownTile({
    required String title,
    required String value,
    required List<int> items,
    required int currentValue,
    required ValueChanged<int> onChanged,
    required String suffix,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingL, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textMain,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppDimens.radiusS),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: currentValue,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: AppColors.textSecondary),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
                dropdownColor: AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimens.radiusM),
                items: items.map((s) => DropdownMenuItem(
                  value: s,
                  child: Text('$s $suffix'),
                )).toList(),
                onChanged: (v) => onChanged(v!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 20,
      endIndent: 20,
      color: AppColors.textSecondary.withValues(alpha: 0.05),
    );
  }
}