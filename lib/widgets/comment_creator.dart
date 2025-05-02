import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentCreator extends StatelessWidget{
  final String postId;
  const CommentCreator({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 12.0),
          Expanded(
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Write a comment...',
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              final text = commentController.text.trim();
              if(text.isNotEmpty) {
                final user = FirebaseAuth.instance.currentUser!;
                final userData = await FirebaseFirestore.instance
                  .collection('users')
                  .where('uid', isEqualTo: user.uid)
                  .limit(1)
                  .get();
                final username = userData.docs.first.data()['username'];
                final profilePic = userData.docs.first.data()['profilePic'];
                final postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
                final commentsRef = postRef.collection('comments');

                await FirebaseFirestore.instance.runTransaction((transaction) async {
                  final snapshot = await transaction.get(postRef);
                  final currentCount = snapshot.data()?['commentsCount'] ?? 0;  

                  transaction.set(commentsRef.doc(), {
                    'userId': user.uid,
                    'username': username,
                    'profilePic': profilePic,
                    'content': text,
                    'timestamp': FieldValue.serverTimestamp(),
                  });
                  transaction.update(postRef, {
                    'commentsCount': currentCount + 1,
                  });
                });
                  commentController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Comment posted successfully!'))
                  );
              }
            }, 
            icon: Icon(Icons.send)
          )
        ],
      )
    );
  }
}