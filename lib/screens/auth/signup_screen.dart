import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                final query = await FirebaseFirestore.instance
                  .collection('users')
                  .where('username', isEqualTo: usernameController.text.trim())
                  .limit(1)
                  .get();

                final usernameExists = query.docs.isNotEmpty;
                if(usernameExists){
                  print("Cannot set username to that of another user's");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('That username is already taken! Please choose a new one'))
                  );
                  return;
                }
                if(passController.text.trim().length < 6){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password must be at least 6 characters'))
                  );
                  return;
                }
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
                    usernameController.text.trim(),
                    fullNameController.text.trim()
                  );
                  
                  // On login success, redirect to home
                  Navigator.pushReplacementNamed(context, '/login',  arguments: {
                      'snackbarMessage': 'You signed up sucessfully! Please log in using your credentials.',
                    });
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
                Navigator.pushReplacementNamed(context, '/login',);
              }, 
              child: const Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  children: [
                    TextSpan(
                      text: 'Log In',
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
