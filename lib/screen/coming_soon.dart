import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key key}) : super(key: key);
  static const kPrimaryColor = Color(0xFF363A99);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
              child: Wrap( 
      children: [
          Text(
            'Coming Soon',
            style: GoogleFonts.openSans(
                fontSize: 100, fontWeight: FontWeight.w700, color: kPrimaryColor),
          ),
      ],
    )),
        ));
  }
}
