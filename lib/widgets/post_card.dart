import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:intl/intl.dart';
import 'package:se330_project_2/models/post.dart';
import 'package:se330_project_2/screens/full_post_screen.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0
      ),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullPostScreen(post: post),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),  
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(post.authorName),
                  Text(DateFormat.yMd().format(post.timestamp))
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                GetBody(post),
                //_previewText(post.body),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )
            ],
          )
        )
      )
    );
  }
}

String GetBody(Post post){
    final Delta delta = Delta.fromJson(jsonDecode(post.body));
    final Document body = Document.fromDelta(delta);
    return body.toPlainText().trim();
}