import 'package:flutter/material.dart';

class textField extends StatelessWidget {
  final String hint;

  textField({required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: TextField(

        decoration: InputDecoration(
          border: const OutlineInputBorder(),

          hintText: hint,
        ),
      ),
    );
  }
}
