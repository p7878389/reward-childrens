import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:children_rewards/shared/widgets/custom_input_field.dart';
import 'package:children_rewards/shared/widgets/app_dialogs.dart';

// Provider for Daily Limit
final dailyLimitProvider = StateNotifierProvider<DailyLimitNotifier, int>((ref) {
  return DailyLimitNotifier();
});

class DailyLimitNotifier extends StateNotifier<int> {
  DailyLimitNotifier() : super(20) {
    _load();
  }

  static const _key = 'daily_star_limit';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt(_key) ?? 20;
  }

  Future<void> setLimit(int limit) async {
    state = limit;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, limit);
  }
}

class DailyLimitConfigScreen extends ConsumerStatefulWidget {
  const DailyLimitConfigScreen({super.key});

  @override
  ConsumerState<DailyLimitConfigScreen> createState() => _DailyLimitConfigScreenState();
}

class _DailyLimitConfigScreenState extends ConsumerState<DailyLimitConfigScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final initialLimit = ref.read(dailyLimitProvider);
    _controller = TextEditingController(text: initialLimit.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateValue(int delta) {
    int current = int.tryParse(_controller.text) ?? 20;
    int newVal = current + delta;
    if (newVal < 1) newVal = 1;
    if (newVal > 1000) newVal = 1000;
    _controller.text = newVal.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.stars_rounded, color: AppColors.primary),
                  SizedBox(width: 12),
                  Text(
                    "每日获取上限",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "限制所有游戏每日可获取的星星总数，防止沉迷。",
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              
              Row(
                children: [
                  Expanded(
                    child: CustomInputField(
                      controller: _controller,
                      icon: Icons.numbers_rounded,
                      hintText: "输入星星数量",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      _buildArrowBtn(Icons.keyboard_arrow_up_rounded, () => _updateValue(5)),
                      const SizedBox(height: 8),
                      _buildArrowBtn(Icons.keyboard_arrow_down_rounded, () => _updateValue(-5)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 48),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    final val = int.tryParse(_controller.text) ?? 20;
                    await ref.read(dailyLimitProvider.notifier).setLimit(val);
                    if (mounted) {
                      // ignore: use_build_context_synchronously
                      await AppDialogs.showSuccess(context, '配置已保存');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("保存配置", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArrowBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Icon(icon, color: AppColors.textMain, size: 20),
      ),
    );
  }
}