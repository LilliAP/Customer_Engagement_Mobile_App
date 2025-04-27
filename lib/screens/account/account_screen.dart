import 'package:flutter/material.dart';
import 'package:se330_project_2/screens/account/account_wrapper.dart';
import 'package:se330_project_2/widgets/app_bottom_navbar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AccountWrapper(),
      bottomNavigationBar: AppBottomNavBar(selectedIndex: 3)
    );
  }
}
