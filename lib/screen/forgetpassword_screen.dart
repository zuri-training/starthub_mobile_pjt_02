import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/widget/presets.dart';

import '../constants.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      Text('Reset Password', style:  kForgetPasswordHeaderStyle,),
      Text('Enter the email associated with your account and we’ll send an email with an instruction to reset your password', style: kForgetPasswordTextStyle),
      NewTextField(hintText: 'Enter email address'),
      NewButton(buttonText: 'Reset Password'),

    ]));
  }
}
