import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  final double fontSize;
  final double height;
  final double width;

  Logo({required this.fontSize, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: const AssetImage("images/reading.png"),
          height: height,
          width: width,
        ),
        Text(
          "SuperVision",
          style: GoogleFonts.lato(
              textStyle: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: fontSize,
            color: const Color(0xFF104D5B),
          )),
        )
      ],
    );
  }
}
