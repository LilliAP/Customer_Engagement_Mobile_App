import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se330_project_2/screens/guest_partial.dart';
import 'package:se330_project_2/widgets/app_theme.dart';

class PrivateMessageScreen extends StatefulWidget {
  final String receiverId;

  const PrivateMessageScreen({super.key, required this.receiverId});

  @override
  State<PrivateMessageScreen> createState() => _PrivateMessageScreenState();
}

class _PrivateMessageScreenState extends State<PrivateMessageScreen> {
  final TextEditingController messageController = TextEditingController();
  final scrollController = ScrollController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if(user == null){
      return GuestPartial();
    }
    return FutureBuilder<DocumentSnapshot>(
      future: getUserProfile(widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('Profile not found.'));
        }
        final userData = snapshot.data!.data() as Map<String, dynamic>;
        return Scaffold(
          appBar: AppBar(
            title: Text(userData['username'] ?? "Username"),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('timestamp', descending: false)
                    .snapshots(), 
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData  || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('The conversation hasn\'t started.'));
                    }

                    final docs = snapshot.data!.docs;
                    final messages = docs.where((doc) {
                      final data = doc.data() as Map<String, dynamic>;

                      final senderId = data['senderId'];
                      final receiverId = data['receiverId'];

                      if (senderId == null || receiverId == null) {
                        return false; // Skip invalid documents
                      }

                      return (senderId == user!.uid && receiverId == widget.receiverId) || 
                            (senderId == widget.receiverId && receiverId == user!.uid);
                    }).toList();


                    if(messages.isEmpty) {
                      return const Center(child: Text('The conversation hasn\'t started.'));
                    }

                    return ListView.builder(
                      controller: scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final data = messages[index].data() as Map<String, dynamic>;
                        final isSentMessage = data['senderId'] == user!.uid;
                        return Align(
                          alignment: isSentMessage ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
                            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: isSentMessage ? AppTheme.appColorScheme.onPrimary 
                                                  : AppTheme.appColorScheme.secondary,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              data['text'],
                              style: TextStyle(
                                color: AppTheme.appColorScheme.surface,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0), 
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type message...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    IconButton(
                      icon: const Icon(Icons.send_rounded),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          )
        );
      }, 
    );
  }

  Future<void> _sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty || user == null) {
      return;
    }

    try{
      await FirebaseFirestore.instance.collection('messages').add({
        'senderId': user!.uid,
        'receiverId': widget.receiverId,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      messageController.clear();
      _scrollDown();
    }
    catch(e) {
      // print('Failed to send message: $e');    // for debugging
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send message')),
      );
    }
  }

  void _scrollDown() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeOut,
      );
    });
  }
}

Future<DocumentSnapshot> getUserProfile(String uid) async {
  final querySnapshot = await FirebaseFirestore.instance
    .collection('users')
    .where('uid', isEqualTo: uid)
    .limit(1)
    .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.first;
  } else {
    throw Exception('User profile not found');
  }
}