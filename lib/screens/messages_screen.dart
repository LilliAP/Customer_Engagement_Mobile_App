import 'package:flutter/material.dart';
import 'package:se330_project_2/screens/messages_wrapper.dart';
import 'package:se330_project_2/widgets/app_bottom_navbar.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MessagesWrapper(),
      bottomNavigationBar: AppBottomNavBar(selectedIndex: 2)
    );
  }
}
