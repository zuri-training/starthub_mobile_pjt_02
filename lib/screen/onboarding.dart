import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Column(
        children: [
          Text(
            'StartHub',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w400,
                color: kBackground,
              ),
            ),
          ),
          VerticalSpacing(),
          Text(
            'Showcasing products and talents',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: kBackground,
              ),
            ),
          ),
          VerticalSpacing(),
          RoundedButton(
            text: ("Let's get started"),
            color: kBackground,
            textColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
