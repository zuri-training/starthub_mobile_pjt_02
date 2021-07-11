import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starthub_mobile_pjt/screen/welcome.dart';

import 'package:starthub_mobile_pjt/widget/presets.dart';

import '../constants.dart';

class Onboarding extends StatefulWidget {
  static String id = "Onboarding";
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  

  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 10.0,
      width: isActive ? 19.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? kPrimaryColor : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget getStartedButton() {
    return _currentPage == _numPages - 1
        ? NewButton(
            buttonText: "Get Started",
            color: kPrimaryColor,
            textColor: Colors.white,
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => WelcomeScreen())))
        : GestureDetector(
            onTap: () => _pageController.animateToPage(_currentPage + 1,
                duration: Duration(milliseconds: 500), curve: Curves.linear),
            child: Container(
              height: 64,
              width: 64,
              child: Icon(
                FontAwesomeIcons.angleRight,
                size: 25,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF363A99),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Image(
                    image: AssetImage('assets/images/starthub.png'),
                    height: 36,
                    width: 127),
              ),
              Expanded(
                flex: 3,
                child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        ResusableSlides(
                            image: AssetImage('assets/images/slide2.png'),
                            onBoardContentText: 'Showcase your portfolio.'),
                        ResusableSlides(
                            image: AssetImage('assets/images/slide3.png'),
                            onBoardContentText:
                                'Discover talent for your next project from the profiles of our interns '),
                        ResusableSlides(
                            image: AssetImage('assets/images/slide2.png'),
                            onBoardContentText:
                                'Developers and Designers from all fields available on Starthub.'),
                      ],
                    )),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator()),
                    Spacer(flex: 5),
                    getStartedButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResusableSlides extends StatelessWidget {
  ResusableSlides(
      {this.onBoardheaderText, this.image, this.onBoardContentText});

  final String onBoardheaderText;
  final String onBoardContentText;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(image: image, height: 280, width: 421),
        SizedBox(height: 10),
        Text(
          onBoardContentText,
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}

