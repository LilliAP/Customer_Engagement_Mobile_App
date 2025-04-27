import 'package:cloud_firestore/cloud_firestore.dart';
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
          "Account Information", 
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold, 
            fontSize: 28.0
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _getUserProfile(user),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Profile not found.'));
          }
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                Center(
                  child: Image.asset(
                    userData['profilePic'] ?? "assets/images/pp1.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                ),
                const SizedBox(height: 10.0),
                Text(
                  userData['fullName'] ?? "Full Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  userData['username'] ?? "Username",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '${user?.email ?? Placeholder}', 
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30.0),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Redirect to Help Page'))
                    );
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
            )
          );
        }
      ),
    );
  }
}

Future<DocumentSnapshot> _getUserProfile(User? user) async {
  if (user == null) throw Exception('No logged in user');

  final querySnapshot = await FirebaseFirestore.instance
    .collection('users')
    .where('uid', isEqualTo: user.uid)
    .limit(1)
    .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.first;
  } else {
    throw Exception('User profile not found');
  }
}