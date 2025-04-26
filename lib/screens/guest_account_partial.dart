import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GuestAccountPartial extends StatelessWidget {
  const GuestAccountPartial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 10.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset("assets/images/kagLogo.png")
            ),
            Text(
              "Create an account to unlock all features!", 
              style: GoogleFonts.lora(
                fontWeight: FontWeight.bold, 
                fontSize: 25.0
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20.0,),
                    Text('- ', style: TextStyle(fontSize: 24)),
                    Expanded(child: Text('Create your own posts')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20.0,),
                    Text('- ', style: TextStyle(fontSize: 24)),
                    Expanded(child: Text('Save, like, and comment on posts')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20.0,),
                    Text('- ', style: TextStyle(fontSize: 24)),
                    Expanded(child: Text('Chat privately with other users')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 80.0),
            ElevatedButton(
              onPressed: () async {
                  Navigator.pushReplacementNamed(context, '/signup');
              }, 
              child: const Text(
                'Sign Up Now!', 
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ),
    );
  }
}
