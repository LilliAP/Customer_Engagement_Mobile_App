// TODO: Implement Edit Profile Page

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se330_project_2/widgets/profile_pic_selector.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
@override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String? selectedProfilePic;
  bool isTextSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile", 
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
          if (!isTextSet) {
            fullNameController.text = userData['fullName'] ?? '';
            usernameController.text = userData['username'] ?? '';
            selectedProfilePic = userData['profilePic'] ?? "assets/images/pp1.png";
            isTextSet = true; // Mark as done!
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30.0),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                            final selection = await showDialog<String>(
                            context: context, 
                            builder: (context) => const ProfilePicSelector()
                          );
                          if(selection != null){
                            setState(() {
                              selectedProfilePic = selection;
                            });
                          }
                        },    
                        child: Image.asset(
                          selectedProfilePic ?? userData['profilePic'],
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text("Edit Profile Picture"),
                    ],
                  )
                ),
                const SizedBox(height: 100.0),
                TextField(
                  controller: fullNameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                const SizedBox(height: 110.0),
                ElevatedButton(
                  onPressed: () async {
                      await UpdateProfileInfo(fullNameController.text.trim(), usernameController.text.trim(), selectedProfilePic!);
                      Navigator.pushReplacementNamed(context, '/account');
                  }, 
                  child: const Text(
                    'Save Changes', 
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    super.dispose();
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

Future<void> UpdateProfileInfo(String fullName, String username, String profilePic) async {
  final user = FirebaseAuth.instance.currentUser;
  if(user != null){
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'username': username,
      'fullName': fullName,
      'profilePic': profilePic,
    }, SetOptions(merge: true));
  }
}