import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se330_project_2/models/post.dart';
import 'package:se330_project_2/widgets/app_bottom_navbar.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.authorName),
              );
            },
          );
        }
      ),
      bottomNavigationBar: AppBottomNavBar(selectedIndex: 1)
    );
  }
}
