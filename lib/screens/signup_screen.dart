// TODO: Implement Signup UI and Logic

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: const Center(
        child: Text('Signup Page Placeholder'),
      ),
    );
  }
}
