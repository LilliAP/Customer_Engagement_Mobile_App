import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_quill/flutter_quill.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final QuillController bodyController = QuillController.basic();
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: ' Title'),
            ),
            const SizedBox(height: 40.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                children: [
                  QuillSimpleToolbar(
                    controller: bodyController,
                    config: const QuillSimpleToolbarConfig(
                      showDividers: false,
                      showUndo: false,
                      showRedo: false,
                      showFontFamily: false,
                      showFontSize: false,
                      showCodeBlock: false,
                      showHeaderStyle: false,
                      showInlineCode: false,
                      showColorButton: false,
                      showBackgroundColorButton: false,
                      showSearchButton: false,
                      showListCheck: false,
                      showSubscript: false,
                      showSuperscript: false,
                      showLink: false,
                      showQuote: false,
                      showListBullets: false,
                      showListNumbers: false,
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: Padding(
                      padding: EdgeInsets.all(10.0), 
                      child: QuillEditor.basic(
                        controller: bodyController,
                        config: const QuillEditorConfig(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: null, 
                  child: Row(
                    children: [
                      Icon(Icons.save_outlined), 
                      const SizedBox(width: 5.0,), 
                      Text(' Save Draft '),
                    ], 
                  )
                ),
                ElevatedButton(
                  onPressed: () async { 
                    final title = titleController.text.trim();
                    final body = jsonEncode(bodyController.document.toDelta().toJson());
                    final bodyText = bodyController.document.toPlainText().trim();    // for validation checking
                    final user = FirebaseAuth.instance.currentUser;

                    if(title.isEmpty || bodyText.isEmpty || user == null){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Title and body are required')
                        )
                      );
                      return;
                    }

                    try{
                      await FirebaseFirestore.instance.collection('posts').add({
                        'title': title,
                        'body': body,
                        'authorId': user.uid,
                        'authorName': user.displayName ?? 'Placeholder',
                        'timestamp': FieldValue.serverTimestamp(), 
                      });

                      Navigator.pop(context);
                    }
                    catch(e){
                      // print('Failed to create post: $e');  // for debugging
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to create post')
                        )
                      );
                    }
                  }, 
                  child: Row(
                    children: [
                      Icon(Icons.edit_outlined), 
                      const SizedBox(width: 5.0,), 
                      Text('Publish Post'),
                    ], 
                  )
                )
              ],
            )
          ],
        )
      )
    );
  }
}