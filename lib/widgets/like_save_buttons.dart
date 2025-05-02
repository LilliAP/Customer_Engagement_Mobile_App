import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se330_project_2/models/post.dart';

class LikeSaveButtons extends StatelessWidget{
  final Post post;
  const LikeSaveButtons({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final isLiked = post.likes.contains(userId);
    final isSaved = post.saves.contains(userId);
    return (userId == null)
    ? Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Log in or sign up to like posts!'))
            );}, 
          child: Icon(
            Icons.favorite_border,
            size: 22.0,
          ),
        ),
        const SizedBox(width: 2.0),
        Text('${post.likesCount}'),
        const SizedBox(width: 16.0),
        GestureDetector(
          onTap: () async {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Log in or sign up to save posts!'))
            );}, 
          child: Icon(
            Icons.bookmark_border,
            size: 22.0,
          ),
        ),
        SizedBox(width: 2.0),
        Text('${post.savesCount}'),
        const SizedBox(width: 16.0),
        Icon(
          Icons.messenger_outline, 
          size: 22.0
        ),
        const SizedBox(width:2.0),
        Text('${post.commentsCount}'),
      ],
    ) 
    : Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => toggleLike(post.id, userId, isLiked),
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            size: 22.0,
          ),
        ),
        const SizedBox(width: 2.0),
        Text('${post.likesCount}'),
        const SizedBox(width: 16.0),
        GestureDetector(
          onTap: () => toggleSave(post.id, userId, isSaved), 
          child: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border, size: 22),
        ),
        const SizedBox(width: 2.0),
        Text('${post.savesCount}'),
        const SizedBox(width: 16.0),
        Icon(
          Icons.messenger_outline, 
          size: 22.0
        ),
        const SizedBox(width:2.0),
        Text('${post.commentsCount}'),
      ],
    );
  }  
}

Future<void> toggleLike(String postId, String userId, bool isLiked) async {
  final postRef = FirebaseFirestore.instance.collection('posts').doc(postId);

   await FirebaseFirestore.instance.runTransaction((transaction) async {
    final snapshot = await transaction.get(postRef);
    final data = snapshot.data()!;
    final currentLikes = List<String>.from(data['likes'] ?? []);
    final currentCount = data['likesCount'] ?? 0;

    if (isLiked) {
      currentLikes.remove(userId);
      transaction.update(postRef, {
        'likes': currentLikes,
        'likesCount': currentCount - 1,
      });
    } else {
      currentLikes.add(userId);
      transaction.update(postRef, {
        'likes': currentLikes,
        'likesCount': currentCount + 1,
      });
    }
  });
}

Future<void> toggleSave(String postId, String userId, bool isSaved) async {
  final postRef = FirebaseFirestore.instance.collection('posts').doc(postId);

  await FirebaseFirestore.instance.runTransaction((transaction) async {
    final snapshot = await transaction.get(postRef);
    final data = snapshot.data()!;
    final currentSaves = List<String>.from(data['saves'] ?? []);
    final currentCount = data['savesCount'] ?? 0;

    if (isSaved) {
      currentSaves.remove(userId);
      transaction.update(postRef, {
        'saves': currentSaves,
        'savesCount': currentCount - 1,
      });
    } else {
      currentSaves.add(userId);
      transaction.update(postRef, {
        'saves': currentSaves,
        'savesCount': currentCount + 1,
      });
    }
  });
}