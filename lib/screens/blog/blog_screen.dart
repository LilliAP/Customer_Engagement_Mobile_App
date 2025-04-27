import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se330_project_2/models/post.dart';
import 'package:se330_project_2/widgets/app_bottom_navbar.dart';
import 'package:se330_project_2/widgets/post_card.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blog Posts", 
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold, 
            fontSize: 28.0
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('timestamp', descending: true)
          .snapshots(), 
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
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
      floatingActionButton: FirebaseAuth.instance.currentUser != null ? 
        FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/create_post');
          },
          icon: Icon(Icons.edit_outlined),
          label: Text('Create Post'),
        )
        : null,
      bottomNavigationBar: AppBottomNavBar(selectedIndex: 1)
    );
  }
}
