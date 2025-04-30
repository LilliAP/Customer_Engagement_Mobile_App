// TODO: Implement Edit Profile Page

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController newPassController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();

    emailController.text = user!.email!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Account", 
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold, 
            fontSize: 28.0
          ),
        ),
      ),
      body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: newPassController,
                  decoration: const InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                ),
                TextField(
                  controller: confirmPassController,
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                ),
                
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () async {
                      Navigator.pop(context);
                  }, 
                  child: const Text(
                    'Save Changes', 
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          )
    );
  }
}
