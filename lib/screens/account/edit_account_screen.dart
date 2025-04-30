// TODO: Implement Edit Profile Page

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se330_project_2/services/auth_service.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController newPassController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();
    final AuthService authService = AuthService();
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
            const SizedBox(height: 15.0,),
            Image.asset(
              "assets/images/croppedKagLogo.png",
              height: 150.0,
              width: 150.0,  
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 70.0),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20.0,),
            SizedBox(
              width: 190.0,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await authService.updateEmail(
                      emailController.text.trim(),
                    );
                    
                    // On login success, redirect to home
                    Navigator.pushReplacementNamed(context, '/login', arguments: 'Your email was updated sucessfully! Please verify your new email then log in again.',);
                  }
                  catch(e) {
                    print('$e');  // used for debugging
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to Change Account Email'))
                    );
                    return;
                  }
                }, 
                child: const Text(
                  'Change Email', 
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 50.0,),
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
            const SizedBox(height: 20.0),
            SizedBox(
              width: 190.0,
              child: ElevatedButton(
                onPressed: () async {
                  if(newPassController.text != "" && newPassController.text.trim().length < 6){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password must be at least 6 characters'))
                    );
                    return;
                  }
                  if(newPassController.text.trim() != confirmPassController.text.trim()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Passwords do not match'))
                    );
                    return;
                  }
                  try {
                    await authService.updatePassword(
                      newPassController.text.trim(),
                    );
                    
                    // On login success, redirect to home
                    Navigator.pushReplacementNamed(context, '/login', arguments: 'Your password was updated successfully. Please log in again.',);
                  }
                  catch(e) {
                    print('$e');  // used for debugging
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to Change Password'))
                    );
                  }
                }, 
                child: const Text(
                  'Change Password', 
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}
