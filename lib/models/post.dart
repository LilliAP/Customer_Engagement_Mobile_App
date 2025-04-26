import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final String body;
  final String authorId;
  final String authorName;
  final DateTime timestamp;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.authorId,
    required this.authorName,
    required this.timestamp,
  });

  factory Post.fromMap(Map<String, dynamic> map, String documentId) {
    return Post(
      id: documentId, 
      title: map['title'], 
      body: map['body'], 
      authorId: map['authorId'], 
      authorName: map['authorName'], 
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}