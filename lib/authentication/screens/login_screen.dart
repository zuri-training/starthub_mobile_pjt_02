import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starthub_mobile_pjt/authentication/screens/signup_screen.dart';

import '../constants.dart';
import '../presets.dart';





class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _passwordVisible;
  TextEditingController _userPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  Widget _passwordField() {
    return TextField(
        keyboardType: TextInputType.text,
        controller: _userPasswordController,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: kHintTextStyle,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                )),
            suffix: GestureDetector(
                onTap: () => setState(() {
                  _passwordVisible = !_passwordVisible;
                }),
                child: _passwordVisible
                    ? Text('Hide', style: kPasswordRevealStyle)
                    : Text('Show', style: kPasswordRevealStyle)),
            fillColor: kTextFieldFillColor,
            filled: true));
  }

  Widget _nameField() {
    return NewTextField(hintText: 'Email');
  }

  Widget _submitButton() {
    return NewButton(
      buttonText: 'Log In',
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenSize.height),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    NewHeaders(
                      headerText: 'StartHub',
                    ),
                    _nameField(),
                    SizedBox(height: 24),
                    _passwordField(),
                    SizedBox(height: 32),
                    _submitButton(),
                    SizedBox(height: 15),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      NewInkWell(text: 'Forget Password'),
                      SizedBox(height: 50)
                    ]),
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('or login in', style: kOrLoginTextStyle),
                          NewInkWell(
                              text: 'Google', icon: FontAwesomeIcons.google),
                          NewInkWell(
                              text: 'Github', icon: FontAwesomeIcons.github)
                        ]),
                    SizedBox(height: 31),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Don\'t have an account?', style: kOrLoginTextStyle),
                      SizedBox(width: 5),
                      InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp())),
                          child: Text('Create an account',
                              style: kInkWellTextStyle))
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
