import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF363A99);
const kTextColor = Color(0xFF363A99);
const kIconColor = Color(0xFF5E5E5E);
const kBackground = Color(0xFFE5E5E5);

const kFont = "Open Sans";
const kFontSize = 13;
const kHintFieldTextColor = Color(0xFFBDBDBD);
const kTextFieldFillColor = Color(0xFFF6F6F6);

//TEXT STYLES
const kHeaderTextStyle = TextStyle(
    fontSize: 36,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w600,
    color: kPrimaryColor);

const kHintTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w500,
  color: kHintFieldTextColor,
);

const kButtonTextStyle = TextStyle(
  fontSize: 18,
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

const kInkWellTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w500,
  color: kPrimaryColor,
  decoration: TextDecoration.underline,
);

const kOrLoginTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w400,
);

const kPasswordRevealStyle = TextStyle(
  fontSize: 16,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w500,
  color: kPrimaryColor,
);

final kDefaultShadow = BoxShadow(
  offset: Offset(5, 5),
  blurRadius: 10,
  color: Color(0xFFE9E9E9).withOpacity(0.56),
);

// For add free space vertically
class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({Key key, this.of = 0.02}) : super(key: key);
  final double of;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * of,
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;

  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 45),
            backgroundColor: color,
          ),
          onPressed: press,
          child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ) !=
                  null
              ? Text(
                  text,
                  style: TextStyle(color: textColor),
                )
              : null,
        ),
      ),
    );
  }
}
