import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();

    final AuthService authService = AuthService();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Image.asset("assets/images/kagLogo.png")
            ),
            const SizedBox(height: 5.0),
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(labelText: '  Full Name'),
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: '  Username'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: '  Email'),
            ),
            TextField(
              controller: passController,
              decoration: const InputDecoration(labelText: '  Password'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPassController,
              decoration: const InputDecoration(labelText: '  Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                  onPressed: () async {
                    if(passController.text.trim() != confirmPassController.text.trim()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Passwords do not match'))
                      );
                      return;
                    }
                    try {
                      await authService.signUp(
                        emailController.text.trim(),
                        passController.text.trim(),
                      );
                      // On login success, redirect to home
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                    catch(e) {
                      //print('Sign Up Failed: $e');  // used for debugging
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sign up failed'))
                      );
                    }
                  }, 
                  child: const Text('Sign Up'),
                ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              }, 
              child: const Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  children: [
                    TextSpan(
                      text: 'Log In!',
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
