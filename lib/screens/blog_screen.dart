import 'package:flutter/material.dart';
import 'package:se330_project_2/widgets/app_bottom_navbar.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blog Posts')),
      body: const Center(
        child: Text('Blog Posts Page Placeholder'),
      ),
      bottomNavigationBar: AppBottomNavBar(selectedIndex: 1)
    );
  }
}
