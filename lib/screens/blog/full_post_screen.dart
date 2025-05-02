import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:intl/intl.dart';
import 'package:se330_project_2/widgets/comment_creator.dart';
import 'dart:convert';
import '../../models/post.dart'; // your Post model

class FullPostScreen extends StatelessWidget {
  final Post post;

  const FullPostScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    // Decode the body JSON back into a Quill document
    final Delta delta = Delta.fromJson(jsonDecode(post.body));
    final QuillController bodyController = QuillController(
      document: Document.fromDelta(delta),
      readOnly: true,
      selection: const TextSelection.collapsed(offset: 0),
    );

    return Scaffold(
      appBar: AppBar(),   // For back arrow
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Post Title
              Text(
                post.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(height: 8),

              // Author and Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(post.authorName,),
                  const SizedBox(width: 10),
                  Text(_formattedDate(post.timestamp),),
                ],
              ),
              const SizedBox(height: 35.0),

              // Body
              QuillEditor.basic(
                controller: bodyController,
                config: const QuillEditorConfig(),
              ),
              const SizedBox(height: 100.0),
              // Add Comment
              CommentCreator(postId: post.id),
              // Comments
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(post.id)
                  .collection('comments')
                  .orderBy('timestamp', descending: false)
                  .snapshots(), 
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final comments = snapshot.data!.docs;
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      thickness: 0.5,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final data = comments[index].data() as Map<String, dynamic>;
                      return ListTile(
                        leading: Image.asset(
                          data['profilePic'] ?? 'assets/images/pp1.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(data['username'] ?? 'Anonymous'),
                        subtitle: Text(data['content'] ?? ''),
                        trailing: Text(DateFormat('MMM d, h:mm a').format(
                          (data['timestamp'] as Timestamp).toDate())),
                      );
                    }
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  String _formattedDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}
