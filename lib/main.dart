import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:se330_project_2/screens/account/account_screen.dart';
import 'package:se330_project_2/screens/account/edit_account_screen.dart';
import 'package:se330_project_2/screens/account/published_posts_screen.dart';
import 'package:se330_project_2/screens/account/reauth_screen.dart';
import 'package:se330_project_2/screens/account/saved_posts_screen.dart';
import 'package:se330_project_2/screens/auth/auth_wrapper.dart';
import 'package:se330_project_2/screens/blog/blog_screen.dart';
import 'package:se330_project_2/screens/blog/create_post_screen.dart';
import 'package:se330_project_2/screens/account/edit_profile_screen.dart';
import 'package:se330_project_2/screens/home_screen.dart';
import 'package:se330_project_2/screens/auth/login_screen.dart';
import 'package:se330_project_2/screens/messages/messages_screen.dart';
import 'package:se330_project_2/screens/auth/signup_screen.dart';
import 'package:se330_project_2/screens/messages/start_message_screen.dart';
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
        '/published_posts': (context) => const PublishedPostsScreen(),
        '/saved_posts': (context) => const SavedPostsScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
        '/reauth_user': (context) => const ReauthScreen(),
        '/edit_account': (context) => const EditAccountScreen(),
        '/create_post': (context) => const CreatePostScreen(),
        '/start_message': (context) => const StartMessageScreen(),
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
    );
  }
}

