import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<String> profilePicPaths = [
  'assets/images/pp1.png',
  'assets/images/pp2.png',
  'assets/images/pp3.png',
  'assets/images/pp4.png',
  'assets/images/pp5.png',
  'assets/images/pp6.png',
  'assets/images/pp7.png',
  'assets/images/pp8.png',
  'assets/images/pp9.png',
];

class ProfilePicSelector extends StatelessWidget{
  const ProfilePicSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Profile Picture'),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: profilePicPaths.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ), 
          itemBuilder: (context, index){
            final profilePic = profilePicPaths[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop(profilePic);
              },
              child: Image.asset(
                profilePic,
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover 
              ),
            );
          })
      )
    );
  }
}