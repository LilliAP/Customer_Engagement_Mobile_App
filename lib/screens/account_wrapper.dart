import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se330_project_2/screens/guest_account_partial.dart';
import 'package:se330_project_2/screens/user_account_partial.dart';

class AccountWrapper extends StatelessWidget {
  const AccountWrapper({super.key});

  @override
  Widget build(BuildContext context){
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      return const UserAccountPartial();
    }
    else{
      return const GuestAccountPartial();
    }
  }
}