import 'package:flutter/material.dart';


const kPrimaryColor = Color(0xFF363A99);
const kTextColor = Color(0xFF363A99);
const kIconColor = Color(0xFF5E5E5E);
const kBackground = Color(0xFFE5E5E5);
const kfont = "Open Sans";

const kDefaultPadding = 20.0;

final kDefualtShadow = BoxShadow(
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
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 45),
          color: color,
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
