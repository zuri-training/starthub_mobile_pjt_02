import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starthub_mobile_pjt/widget/presets.dart';

import '../constants.dart';

class EnterEmail extends StatefulWidget {
  @override
  _EnterEmailState createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  final _emailController = TextEditingController();

  var spacing = SizedBox(height: 15);

  Widget _enterEmail() {
    return NewerTextField(
        hintText: 'Enter email address', controller: _emailController);
  }

  Widget _submitButton() {
    return NewButton(
        buttonText: 'Reset Password',
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CheckMail())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.angleLeft,
            color: kPrimaryColor,
            size: 20.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Reset Password',
              style: GoogleFonts.raleway(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
            spacing,
            Wrap(children: [
              Text(
                  'Enter the email associated with your account and we’ll send an email with an instruction to reset your password.',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            spacing,
            _enterEmail(),
            spacing,
            _submitButton(),
          ]),
        ),
      ),
    );
  }
}

class CheckMail extends StatefulWidget {
  @override
  _CheckMailState createState() => _CheckMailState();
}

class _CheckMailState extends State<CheckMail> {
  var spacing = SizedBox(height: 15);

  Widget _submitButton() {
    return NewButton(buttonText: 'Open mail app', onTap: () => print('done'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.envelope,
                    size: 100,
                    color: kPrimaryColor,
                  ),
                  spacing,
                  Text(
                      'We have sent a password recover instructions to your mail',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                  _submitButton(),
                ])),
      ),
    );
  }
}

class NewerTextField extends StatelessWidget {
  NewerTextField({
    @required this.hintText,
    @required this.controller,
    this.obscureText = false,
  });

  final String hintText;
  final TextEditingController controller;

  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: kHintFieldTextColor,
          ),
          fillColor: Color(0xFFF6F6F6),
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ))),
    );
  }
}
