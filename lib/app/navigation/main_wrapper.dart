import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/shared/widgets/custom_bottom_nav.dart';
import 'package:children_rewards/features/children/presentation/screens/home_screen.dart';
import 'package:children_rewards/features/rewards/presentation/screens/rewards_store_screen.dart';
import 'package:children_rewards/features/rule/presentation/screens/rules_manage_screen.dart';
import 'package:children_rewards/features/settings/presentation/screens/settings_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const RewardsStoreScreen();
      case 2:
        return const RulesManageScreen(showBackButton: false);
      case 3:
        return const SettingsScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: _buildPage(_selectedIndex),
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
