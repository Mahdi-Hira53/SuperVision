import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/log_in/login.dart';
import 'package:login/log_in/sign_in.dart';
import 'package:login/utility/text_field.dart';

import '../utility/reusable_button.dart';

class newPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20.5),
            child: Text(
              "Set new password",
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 25)),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.5),
            child: Text(
              "Your new password must differ from your previous one",
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16)),
              textAlign: TextAlign.center,
            ),
          ),
          textField(hint: 'Password'),
          Text(
            "Must be at least 8 character",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(fontSize: 12),
            ),
            textAlign: TextAlign.center,
          ),
          textField(hint: 'Confirm Password'),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              "Both password must match",
              style: GoogleFonts.lato(
                textStyle: const TextStyle(fontSize: 12),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Button(
              buttonName: 'Reset Password',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => signIn(),
                    ),);
              })
        ],
      ),
    );
  }
}
