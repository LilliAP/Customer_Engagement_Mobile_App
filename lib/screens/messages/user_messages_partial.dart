import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se330_project_2/screens/messages/private_message_screen.dart';

class UserMessagesPartial extends StatelessWidget {
  const UserMessagesPartial({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Private Messages", 
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold, 
            fontSize: 28.0
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Chats Yet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text('Start one now by pressing the \'Message\' button!'),
                ],
              )
            );
          }
          final docs = snapshot.data!.docs;
          final Set<String> messagedUsers = {};
          print('Logged in UID: ${user!.uid}');
          for(var doc in docs) {
            final data = doc.data() as Map<String, dynamic>;
            final senderId = data['senderId'];
            final receiverId = data['receiverId'];
            if (senderId == user!.uid) {
              messagedUsers.add(receiverId);
            }
            else if (receiverId == user.uid) {
              messagedUsers.add(senderId);
            }
            print('senderId: $senderId | receiverId: $receiverId');
          }

          final messagedUsersList = messagedUsers.toList();

          if(messagedUsersList.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Chats Yet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text('Start one now by pressing the \'Message\' button!'),
                ],
              ),
            );
          }
          
          return ListView.builder(
            itemCount: messagedUsersList.length,
            itemBuilder: (context, index) {
              final messagedUserId = messagedUsersList[index];

              return ListTile(
                title: Text('User ID: $messagedUserId'),  // TODO: Replace with username
                trailing: const Icon(Icons.chat),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivateMessageScreen(receiverId: messagedUserId),
                    ),
                  );
                },
              );
            }
          );
        },
      ),
    );
  }
}
