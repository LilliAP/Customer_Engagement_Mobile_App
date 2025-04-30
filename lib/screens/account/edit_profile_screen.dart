// TODO: Implement Edit Profile Page

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se330_project_2/widgets/profile_pic_selector.dart';

const List<String> profilePicPaths = [
  'assets/images/pp1.png',
  'assets/images/pp2.png',
  'assets/images/pp3.png',
  'assets/images/pp4.png',
  'assets/images/pp5.png',
  'assets/images/pp6.png',
  'assets/images/pp7.png',
  'assets/images/pp8.png',
  'assets/images/pp9.png',
];

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
  bool showImageGrid = false;

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
                  child: ProfilePicSelector(
                    initialPic: selectedProfilePic!,
                    onPicSelected: (newPic) {
                      setState(() {
                        selectedProfilePic = newPic;
                      });
                    },
                  ),
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
                      await _updateProfileInfo(fullNameController.text.trim(), usernameController.text.trim(), selectedProfilePic!);
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

Future<void> _updateProfileInfo(String fullName, String username, String profilePic) async {
  print('Selected profile pic: $profilePic');

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