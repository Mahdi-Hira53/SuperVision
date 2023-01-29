import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/log_in/sign_up.dart';
import 'package:login/teacher/home_page.dart';
import 'package:login/utility/reusable_button.dart';
import 'package:login/utility/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forget_password.dart';
import 'main_page.dart';

class signIn extends StatefulWidget {
  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _isTrue = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo(fontSize: 20, width: 100, height: 100),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      obscureText: _isTrue,
                      controller: password,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isTrue = !_isTrue;
                              });
                            },
                            icon: Icon(_isTrue
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        border: const OutlineInputBorder(),
                        hintText: "Password",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => forgetPassword(),
                      ));
                },
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
            Button(
              buttonName: "Log In",
              onPressed: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                    email: email.text.trim(),
                    password: password.text.trim(),
                  );
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ),
                    );
                  }
                } on FirebaseException catch (e) {
                  if (_formKey.currentState!.validate()) {
                  }
                    final snackBar = SnackBar(
                      content: Text(e.message!),
                      backgroundColor: Color(0xFF104D5B),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    print(e);

                }
              },
            ),
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
    );
  }
}
