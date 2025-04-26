import 'package:flutter/material.dart';
import 'package:se330_project_2/widgets/app_theme.dart';

class AppBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const AppBottomNavBar({super.key, required this.selectedIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return;

    String destination;
    switch (index) {
      case 0:
        destination = '/home';
        break;
      case 1: 
        destination = '/blog';
        break;
      case 2: 
        destination = '/messages';
        break;
      case 3:
        destination = '/account';
        break;
      default:
        destination = '/home';
        break;
    }

    Navigator.pushReplacementNamed(context, destination);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // color formatting to make nav bar visible (temporary)
      type: BottomNavigationBarType.fixed, // ensures all are visible
      backgroundColor: AppTheme.appColorScheme.primary,
      selectedItemColor: AppTheme.appColorScheme.onPrimary,
      unselectedItemColor: AppTheme.appColorScheme.onSurfaceVariant,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      // icons and index
      currentIndex: selectedIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: [
        _buildNavItem(Icons.home, "Home", 0),
        _buildNavItem(Icons.article, "Blog", 1),
        _buildNavItem(Icons.wechat_outlined, "Messages", 2),
        _buildNavItem(Icons.account_circle, "Account", 3),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
        ],
      ),
      label: label,
    );
  }
}