import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se330_project_2/screens/home_screen.dart';
import 'package:se330_project_2/screens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      return const HomeScreen();
    }
    else{
      return const LoginScreen();
    }
  }
}