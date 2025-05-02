import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se330_project_2/models/post.dart';
import 'package:se330_project_2/widgets/post_card.dart';

class PublishedPostsScreen extends StatelessWidget {
  const PublishedPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Published Posts", 
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold, 
            fontSize: 28.0
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection('posts')
          .where('authorId', isEqualTo: currentUser.uid)
          .orderBy('timestamp', descending: true)
          .snapshots(), 
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Blog Posts Yet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text('Start one by pressing the \'Create Post\' button!'),
                ],
              )
            );
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var post = Post.fromMap(docs[index].data(), docs[index].id);
              return PostCard(post: post);
            },
          );
        }
      ),
    );
  }
}
