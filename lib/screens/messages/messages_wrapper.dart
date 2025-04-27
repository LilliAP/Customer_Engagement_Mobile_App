import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se330_project_2/screens/guest_partial.dart';
import 'package:se330_project_2/screens/messages/user_messages_partial.dart';

class MessagesWrapper extends StatelessWidget {
  const MessagesWrapper({super.key});

  @override
  Widget build(BuildContext context){
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      return const UserMessagesPartial();
    }
    else{
      return const GuestPartial();
    }
  }
}