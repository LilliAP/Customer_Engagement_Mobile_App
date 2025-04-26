import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:se330_project_2/screens/account_screen.dart';
import 'package:se330_project_2/screens/auth_wrapper.dart';
import 'package:se330_project_2/screens/blog_screen.dart';
import 'package:se330_project_2/screens/home_screen.dart';
import 'package:se330_project_2/screens/login_screen.dart';
import 'package:se330_project_2/screens/messages_screen.dart';
import 'package:se330_project_2/screens/signup_screen.dart';
import 'package:se330_project_2/widgets/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.requestPermission(); // gets perms for notifications

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kag\'s Coffee & Bagels',
      theme: AppTheme.appThemeData,
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/blog': (context) => const BlogScreen(),
        '/messages': (context) => const MessagesScreen(),
        '/account': (context) => const AccountScreen(),
      },
    );
  }
}

