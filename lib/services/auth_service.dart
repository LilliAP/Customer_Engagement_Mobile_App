import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Registration
  Future<UserCredential> signUp(String email, String password, String username, String fullName) async {
   final credential = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
    
    final user = credential.user;
    if(user != null){
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'username': username,
        'fullName': fullName,
        'profilePic': 'assets/images/pp1.png',
      });
    }

    return credential;
  }

  // Login
  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  // Logout
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // Gets the current user
  User? get currentUser => _auth.currentUser;

}

