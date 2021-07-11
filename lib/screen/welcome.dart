import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starthub_mobile_pjt/screen/sign_in.dart';
import 'package:starthub_mobile_pjt/widget/presets.dart';

import 'coming_soon.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  static const kPrimaryColor = Color(0xFF363A99);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(children: [
                    AspectRatio(aspectRatio: 2),
                    Text('StartHub',
                        style: GoogleFonts.raleway(
                            fontSize: 48,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                    Text('Showcasing products and talents',
                        style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ])),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text('Why Starthub?',
                          style: GoogleFonts.openSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                      SizedBox(height: 11),
                      NewButton(
                          buttonText: 'I want to get hired',
                          color: Colors.white,
                          textColor: kPrimaryColor,
                          onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => SignIn()))),
                      SizedBox(height: 11),
                      NewButton(
                        buttonText: 'I want to hire',
                        color: Colors.white,
                        textColor: kPrimaryColor,
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => ComingSoon())),
                      ),
                    ],
                  ))
            ],
          ),
        )));
  }
}
