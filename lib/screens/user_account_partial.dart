import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserAccountPartial extends StatelessWidget {
  const UserAccountPartial({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account", 
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold, 
            fontSize: 28.0
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            Center(
              child: Image.asset(
                "assets/images/kagLogoOnly.png",
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              )
            ),
            const SizedBox(height: 10.0),
            Text(
              "Name Placeholder",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),       // populated by db later
            const SizedBox(height: 8.0),
            Text(
              '${user?.email ?? Placeholder}', 
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60.0),
            ElevatedButton(
              onPressed: () async {
                  Navigator.pushReplacementNamed(context, '/messages');
              }, 
              child: const Text(
                ' Messages ', 
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                  Navigator.pushReplacementNamed(context, '/blog');
              }, 
              child: const Text(
                'Community', 
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                  Navigator.pushNamed(context, '/edit_profile');
              }, 
              child: const Text(
                'Edit Profile', 
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                  // NOT IMPLEMENTING
              }, 
              child: const Text(
                'Contact Us', 
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8.4),
            Align(
              alignment: Alignment.bottomRight, 
              child: IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                }, 
                icon: Icon(
                  Icons.exit_to_app,
                  size: 35.0,
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
