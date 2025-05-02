import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final String body;
  final String authorId;
  final String authorName;
  final DateTime timestamp;
  final List<String> likes;
  final List<String> saves;
  final int likesCount;
  final int savesCount;
  final int commentsCount;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.authorId,
    required this.authorName,
    required this.timestamp,
    required this.likes, 
    required this.saves, 
    required this.likesCount, 
    required this.savesCount, 
    required this.commentsCount,
  });

  factory Post.fromMap(Map<String, dynamic> map, String documentId) {
    return Post(
      id: documentId, 
      title: map['title'], 
      body: map['body'], 
      authorId: map['authorId'], 
      authorName: map['authorName'], 
      timestamp: map['timestamp'] != null && map['timestamp'] is Timestamp
        ? (map['timestamp'] as Timestamp).toDate()
        : DateTime.now(), // fallback if timestamp is missing
      likes: List<String>.from(map['likes'] ?? []),
      saves: List<String>.from(map['saves'] ?? []),
      likesCount: map['likesCount'] ?? 0,
      savesCount: map['savesCount'] ?? 0,
      commentsCount: map['commentsCount'] ?? 0,
    );
  }
}