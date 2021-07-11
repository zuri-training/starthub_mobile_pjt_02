import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starthub_mobile_pjt/screen/project_screen.dart';
import '../constants.dart';


class Onboarding extends StatelessWidget {
  const Onboarding({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
          width: double.infinity,
          height: size.height,
          color: kPrimaryColor,
          child: Column(
            children: [
              VerticalSpacing(of: 0.4,),
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
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectScreen()));
                },
                text: ("Let's get started"),
                color: kBackground,
                textColor: kPrimaryColor,
              ),
            ],
          ),
        );
  }
}
