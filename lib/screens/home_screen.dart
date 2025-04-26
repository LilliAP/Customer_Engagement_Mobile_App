import 'package:flutter/material.dart';
import 'package:se330_project_2/widgets/app_bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text('Home Page Placeholder'),
      ),
      bottomNavigationBar: AppBottomNavBar(selectedIndex: 0)
    );
  }
}
