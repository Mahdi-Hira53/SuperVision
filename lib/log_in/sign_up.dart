import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/utility/constant_login.dart';
import 'package:login/utility/logo.dart';
import 'package:login/utility/reusable_button.dart';
import 'package:login/log_in/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController initialController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _supervisor = false;
  bool _isEnable = false;
  bool _student = false;
  final _formKey = GlobalKey<FormState>();

  final snackBar = const SnackBar(
    content: Text('Password Not Matched'),
  );

  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  void createSupervisorCollection() async{

   await _fireStore.collection("Teacher").doc(initialController.text).set({
      "phone":phoneController.text,
      "name":nameController.text,
      "email":emailController.text,
     "password": passwordController.text
    });
  }

  void createUser() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => signIn(),
        ),
      );
    } on FirebaseException catch (e) {
      SnackBar snackBar = SnackBar(content: Text(e.message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Logo(fontSize: 20, height: 80, width: 100),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 12.0, top: 12),
                        child: TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        child: TextFormField(
                          controller: emailController,
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
                        child: TextFormField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Phone",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Phone Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: Checkbox(
                              value: _supervisor,
                              activeColor: Color(0xFF104D5B),
                              onChanged: (bool? value) {
                                setState(() {
                                  _supervisor = value!;
                                  _student = false;
                                  _isEnable = value!;
                                });
                              },
                            ),
                          ),
                          Text(
                            'Supervisor',
                            style: kTextStyle,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: Checkbox(
                              value: _student,
                              activeColor: const Color(0xFF104D5B),
                              onChanged: (bool? value) {
                                setState(() {
                                  _student = value!;
                                  _supervisor = false;
                                  _isEnable = value!;
                                });
                              },
                            ),
                          ),
                          Text(
                            'Student',
                            style: kTextStyle,
                          ),
                        ],
                      ),
                      _supervisor == true
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 12.0),
                              child: TextFormField(
                                controller: initialController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Enter Your Initial',
                                  enabled: _isEnable,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Initial';
                                  }
                                  return null;
                                },
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(bottom: 12.0),
                              child: TextFormField(
                                controller: idController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Enter Student ID',
                                  enabled: _isEnable,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Student ID';
                                  }
                                  return null;
                                },
                              ),
                            ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Password",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Text(
                        'Must be at least 6 characters',
                        textAlign: TextAlign.left,
                        style: kTextStyle,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 12.0, top: 12),
                        child: TextFormField(
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Confirm Password",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Re - type password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Button(
                  buttonName: 'Sign Up',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                    if (_supervisor == true) createSupervisorCollection();
                    if (passwordController.text ==
                        confirmPasswordController.text) {
                      createUser();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      passwordController.clear();
                      confirmPasswordController.clear();
                    }
                  },
                ),
                Container(
                  margin: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Already have an account?",
                          style: GoogleFonts.firaCode(),
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          " Log In",
                          style: kTextStyle,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => signIn(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
