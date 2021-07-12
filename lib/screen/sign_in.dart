import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:starthub_mobile_pjt/locator.dart';

import 'package:starthub_mobile_pjt/service/authentication.dart';
import 'package:starthub_mobile_pjt/service/dialog_service.dart';
import 'package:starthub_mobile_pjt/service/navigation_service.dart';

import '../constants.dart';
import '../widget/presets.dart';
import 'register.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _passwordVisible;
  final _formkey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final provider = AuthService();
  final DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  Widget _passwordField() {
    return TextField(
        keyboardType: TextInputType.text,
        controller: passwordController,
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
    return NewTextField(
      hintText: 'Email',
      controller: emailController,
    );
  }

  Widget _submitButton({Function pressed}) {
    return NewButton(
      buttonText: 'Log In',
      onTap: pressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        
        body: SafeArea(
          child: Form(
            key: _formkey,
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
                      _submitButton(pressed: () async {
                        if (_formkey.currentState.validate()) {
                          _formkey.currentState.save();
                          print("Email Address: ${emailController.text}" +
                              ' | ' +
                              "Password: ${passwordController.text}");
                         dynamic result = await provider.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          if(result == null) {
                          return _dialogService.showDialog(
                              title: "SignIn Failure",
                              description:
                                  'General SignIn failure. Please try again later');
                        }
                        } 
                      }),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NewInkWell(text: 'Forget Password'),
                            SizedBox(height: 50)
                          ]),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('or SignIn in', style: kHintTextStyle),
                            NewInkWell(
                                text: 'Google', icon: FontAwesomeIcons.google),
                            NewInkWell(
                                text: 'Github', icon: FontAwesomeIcons.github)
                          ]),
                      SizedBox(height: 31),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                                style: kHintTextStyle),
                            SizedBox(width: 5),
                            InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register())),
                                child: Text('Create an account',
                                    style: kInkWellTextStyle))
                          ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
