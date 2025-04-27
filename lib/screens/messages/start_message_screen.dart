import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se330_project_2/screens/messages/private_message_screen.dart';

class StartMessageScreen extends StatefulWidget{
  const StartMessageScreen({super.key});

  @override
  State<StartMessageScreen> createState() => _StartMessageScreen();
}

class _StartMessageScreen extends State<StartMessageScreen> {
  final TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot> searchResults = [];

  Future<void> _searchUsers() async {
    final query = searchController.text.trim();
    if(query.isEmpty) return;

    final snapshot = await FirebaseFirestore.instance.collection('users')
      .where('username', isGreaterThanOrEqualTo: query)
      .where('username', isLessThanOrEqualTo: query)
      .get();
    
    setState(() {
      searchResults = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Start a New Chat", 
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold, 
            fontSize: 28.0
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search username...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search), 
                  onPressed: _searchUsers,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: searchResults.isEmpty ? const Center(child: Text('Search for a user')) 
                : ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final userDoc = searchResults[index];
                    final username = userDoc['username'];
                    final uid = userDoc['uid'];

                    return ListTile(
                      title: Text(username),
                      onTap: () {
                        Navigator.pushReplacement(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => PrivateMessageScreen(receiverId: uid),
                          )
                        );
                      },
                    );
                  },
                )
            ),
          ],
        )
      )
    );
  }
}