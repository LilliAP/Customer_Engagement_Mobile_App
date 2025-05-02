import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se330_project_2/models/post.dart';
import 'package:se330_project_2/widgets/post_card.dart';

class SavedPostsScreen extends StatelessWidget {
  const SavedPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved Posts", 
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold, 
            fontSize: 28.0
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection('posts')
          .where('saves', arrayContains: currentUser.uid)
          .orderBy('timestamp', descending: true)
          .snapshots(), 
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No Saved Blog Posts Yet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
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
