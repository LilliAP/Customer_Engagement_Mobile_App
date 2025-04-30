  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/auth_service.dart';

class ReauthScreen extends StatefulWidget {
  const ReauthScreen({super.key});

  @override
  State<ReauthScreen> createState() => _ReauthScreenState();
}

class _ReauthScreenState extends State<ReauthScreen> {
  final TextEditingController _passController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Authentication", 
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold, 
            fontSize: 28.0
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/kagLogoOnly.png", height: 100.0, width: 100.0),
              const SizedBox(height: 20.0),
              Text("Verify Your Identity", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 40.0),
              TextField(
                controller: _passController,
                decoration: const InputDecoration(labelText: ' Current Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                    onPressed: () async {
                      try {
                        await _authService.reauthenticateUser(
                          _passController.text.trim(),
                        );
                        // On login success, redirect to home
                        Navigator.pushReplacementNamed(context, '/edit_account');
                      }
                      catch(e) {
                        //print('Login Failed: $e');    // used for debugging
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Authentication Failed'))
                        );
                      }
                    }, 
                    child: const Text('Verify'),
                  ),
            ]
          )
        )
      )
    );
  }
}