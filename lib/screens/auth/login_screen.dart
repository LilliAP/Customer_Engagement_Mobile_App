import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Center(
              child: Image.asset("assets/images/kagLogo.png")
            ),
            const SizedBox(height: 40.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: '  Email'),
            ),
            TextField(
              controller: _passController,
              decoration: const InputDecoration(labelText: '  Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                  onPressed: () async {
                    try {
                      await _authService.signIn(
                        _emailController.text.trim(),
                        _passController.text.trim(),
                      );
                      // On login success, redirect to home
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                    catch(e) {
                      //print('Login Failed: $e');    // used for debugging
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login failed'))
                      );
                    }
                  }, 
                  child: const Text('Login'),
                ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signup');
              }, 
              child: const Text.rich(
                TextSpan(
                  text: 'Don\'t have an account? ',
                  children: [
                    TextSpan(
                      text: 'Sign up!',
                      style: TextStyle(fontStyle: FontStyle.italic)
                    )
                  ]
                )
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              }, 
              child: const Text.rich(
                TextSpan(
                  text: 'Or ',
                  children: [
                    TextSpan(
                      text: 'Continue as a Guest',
                      style: TextStyle(fontStyle: FontStyle.italic)
                    )
                  ]
                )
              ),
            ),
          ]
        )
      )
    );
  }
}