import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/utility/logo.dart';
import 'package:login/utility/reusable_button.dart';
import 'package:login/log_in/sign_in.dart';
import 'package:login/log_in/sign_up.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo(fontSize: 20, height: 100, width: 100),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 40, right: 40),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Button(
                      buttonName: 'Sign In',

                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => signIn(),
                            ));
                      }),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Text(
                      textAlign: TextAlign.right,
                      "Did not have an account?",
                      style: GoogleFonts.firaCode(),
                    ),
                  ),
                  Button(
                      buttonName: 'Sign Up',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => signUp(),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
