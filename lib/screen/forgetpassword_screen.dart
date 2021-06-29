import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starthub_mobile_pjt/widget/presets.dart';

import '../constants.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EnterEmail(),
    );
  }
}

class EnterEmail extends StatelessWidget {
  const EnterEmail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(children: [
            Text('Reset Password', style: kHeaderTextStyle),
            Text(
                'Enter the email associated with your account and we’ll send an email with an instruction to reset your password.',
                style: kUniversalTextStyle),
            VerticalSpacing(),
            NewTextField(hintText: 'Enter email address'),
            VerticalSpacing(),
            NewButton(
                buttonText: 'Reset Password',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckMail()))),
          ]),
        ),
      ),
    );
  }
}

class CheckMail extends StatelessWidget {
  const CheckMail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Icon(
                FontAwesomeIcons.envelope,
                size: 40,
              ),
              Text('Check your mail', style: kHeaderTextStyle),
              Text(
                  'Enter the email associated with your account and we’ll send an email with an instruction to reset your password.',
                  style: kUniversalTextStyle),

              NewButton(buttonText: 'Open mail app', onTap: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateNewPassword()))),
              Wrap(
                children: [
                  Text('Did not receive the email? Check your spam folder ',
                      style: kUniversalTextStyle),
                  InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EnterEmail())),
                      child: Text('or try another email address',
                          style: kInkWellTextStyle)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key key}) : super(key: key);

  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool isChecked = false;
  bool _passwordVisible;
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _confirmUserPasswordController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  Widget _passwordField() {
    return TextField(
        keyboardType: TextInputType.text,
        controller: _userPasswordController,
        obscureText: _passwordVisible,
        decoration: InputDecoration(
            hintText: 'Enter new password',
            hintStyle: kHintTextStyle,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                )),
            fillColor: kTextFieldFillColor,
            filled: true));
  }

  Widget _confirmPasswordField() {
    return TextField(
        keyboardType: TextInputType.text,
        controller: _confirmUserPasswordController,
        obscureText: _passwordVisible,
        decoration: InputDecoration(
            hintText: 'Confirm new password',
            hintStyle: kHintTextStyle,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                )),
            fillColor: kTextFieldFillColor,
            filled: true));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Text('Create new password', style: kHeaderTextStyle),
              _passwordField(),
              SizedBox(height: 20),
              _confirmPasswordField(),
              NewButton(buttonText: 'Reset Password'),
            ],
          ),
        ),
      ),
    );
  }
}

