import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/shared/widgets/custom_bottom_nav.dart';
import 'package:children_rewards/features/children/presentation/screens/home_screen.dart';
import 'package:children_rewards/features/rewards/presentation/screens/rewards_store_screen.dart';
import 'package:children_rewards/features/settings/presentation/screens/settings_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    RewardsStoreScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true, // Allow body to extend behind the bottom nav
      body: SafeArea(
        bottom: false, // Scaffold handles bottom bar
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
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
