import 'package:flutter/material.dart';
import 'package:se330_project_2/widgets/app_bottom_navbar.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: const Center(
        child: Text('Messages Page Placeholder'),
      ),
      bottomNavigationBar: AppBottomNavBar(selectedIndex: 2)
    );
  }
}
