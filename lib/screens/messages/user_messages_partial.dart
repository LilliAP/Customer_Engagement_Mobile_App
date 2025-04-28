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
        stream: FirebaseFirestore.instance
          .collection('messages')
          //.orderBy('timestamp', descending: true)   requires global read, removed for now
          .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
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

          docs.sort((a, b) {
            final aData = a.data() as Map<String, dynamic>;
            final bData = b.data() as Map<String, dynamic>;

            final aTimestamp = (aData['timestamp'] as Timestamp?)?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);
            final bTimestamp = (bData['timestamp'] as Timestamp?)?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);

            return bTimestamp.compareTo(aTimestamp); 
          });
          final Set<String> messagedUsers = {};

          for (var doc in docs) {
            final data = doc.data() as Map<String, dynamic>;

            final senderId = data['senderId'];
            final receiverId = data['receiverId'];

            if (senderId == user!.uid) {
              messagedUsers.add(receiverId);
            } else if (receiverId == user.uid) {
              messagedUsers.add(senderId);
            }
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
                  SizedBox(height: 10.0),
                  Text('Start one now by pressing the \'Message\' button!'),
                ],
              ),
            );
          }
          
          return ListView.builder(
            itemCount: messagedUsersList.length,
            itemBuilder: (context, index) {
              final messagedUserId = messagedUsersList[index];

              return FutureBuilder<DocumentSnapshot>(
                future: getUserProfile(messagedUserId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(height: 0.0);
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {





























































































                    
                    return const SizedBox(height: 0.0);
                  }
                  final userData = snapshot.data!.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(userData['username'] ?? "Username"),
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
            }
          );
        },
      ),
      floatingActionButton: FirebaseAuth.instance.currentUser != null ? 
        FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/start_message');
          },
          icon: Icon(Icons.messenger_outline_rounded),
          label: Text('Start a New Chat'),
        )
        : null,
    );
  }
}
