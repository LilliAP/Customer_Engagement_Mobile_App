import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Registration
  Future<UserCredential> signUp(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
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