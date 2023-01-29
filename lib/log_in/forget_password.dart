import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/utility/reusable_button.dart';

class forgetPassword extends StatelessWidget {
  forgetPassword({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20.5),
            child: Text(
              "Forgot Password",
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 25)),
            ),
          ),
          Text(
            "Enter your email associated with your account",
            style: GoogleFonts.lato(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
          ),
          Container(
            margin: const EdgeInsets.all(12.0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
              ),
            ),
          ),
          Button(
              buttonName: 'Send',
              onPressed: () async {
                try {
                  await _auth.sendPasswordResetEmail(
                    email: emailController.text.trim(),
                  );
                  final snackBar = SnackBar(
                      content: const Text('Password Reset Email Sent'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } on FirebaseException catch (e) {
                  final snackBar =
                      SnackBar(content: Text(e.message.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }),
          Container(
            margin: EdgeInsets.all(12.0),
            child: Button(
                buttonName: 'Get Back',
                onPressed: ()  {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }
}
