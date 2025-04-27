import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se330_project_2/screens/home_screen.dart';
import 'package:se330_project_2/screens/auth/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context){
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
        else if (snapshot.hasData) {  // User is logged in
          return const HomeScreen();  
        }
        else{
          return const LoginScreen();
        }
      }
    );
  }
}