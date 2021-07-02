import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:starthub_mobile_pjt/models/login_view_model.dart';
import 'package:starthub_mobile_pjt/screen/signup_screen.dart';
import 'package:starthub_mobile_pjt/widget/presets.dart';

import '../constants.dart';


class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _passwordVisible;
  final _formkey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  get kOrLoginTextStyle => null;

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

  Widget _submitButton(Function pressed) {
    return NewButton(
      buttonText: 'Log In',
      onTap: pressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 35.0,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
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
                            _submitButton(() {
                              if (_formkey.currentState.validate()) {
                                _formkey.currentState.save();
                                print("Email Address: ${emailController.text}");
                                print("Password: ${passwordController.text}");
                              }
                              model.login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('or login in', style: kOrLoginTextStyle),
                                  NewInkWell(
                                      text: 'Google',
                                      icon: FontAwesomeIcons.google),
                                  NewInkWell(
                                      text: 'Github',
                                      icon: FontAwesomeIcons.github)
                                ]),
                            SizedBox(height: 31),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t have an account?',
                                      style: kOrLoginTextStyle),
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
                ),
              ));
        });
  }
}
