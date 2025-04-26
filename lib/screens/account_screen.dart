import 'package:flutter/material.dart';
import 'package:se330_project_2/widgets/app_bottom_navbar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: const Center(
        child: Text('Account Page Placeholder'),
      ),
      bottomNavigationBar: AppBottomNavBar(selectedIndex: 3)
    );
  }
}
