import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

//Headers for login and sign up page
class NewHeaders extends StatelessWidget {
  NewHeaders({this.headerText});
  final String headerText;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6 / 2,
      child: Center(child: Text(headerText, style: kHeaderTextStyle)),
    );
  }
}

//Button for login and sign up page
class NewButton extends StatelessWidget {
  NewButton({
    this.buttonText,
    this.onTap,
    this.busy,
    this.color,
    this.textColor
  });

  final String buttonText;
  final Function onTap;
  final bool busy;
  final Color color, textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 57,
        margin: EdgeInsets.only(top: 5.0),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: color,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.openSans(
                fontSize: 18, fontWeight: FontWeight.w400, color: textColor),
          ),
        ),
      ),
    );
  }
}


//Textfield for login and sign up page
class NewTextField extends StatelessWidget {
  NewTextField({this.hintText, this.controller});
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Center(
            child: TextFormField(
                controller: controller,
                validator: (value) => value.isNotEmpty ? null : "Cannot be empty",
                decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: kHintTextStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        )),
                    fillColor: kTextFieldFillColor,
                    filled: true))));
  }
}

//Inkwell for login and sign up page
class NewInkWell extends StatelessWidget {
  NewInkWell({this.text, this.onTap, this.icon});

  final String text;
  final Function onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 15),
          SizedBox(width: 2),
          Text(text, style: kInkWellTextStyle),
        ],
      ),
    );
  }
}
