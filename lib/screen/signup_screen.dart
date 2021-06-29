import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:starthub_mobile_pjt/models/signup_view_model.dart';

import '../constants.dart';
import '../widget/presets.dart';
import 'login_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isChecked = false;
  bool _passwordVisible;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController _confirmUserPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  Widget _firstNameField() {
    return NewTextField(
      hintText: 'Enter first name',
      controller: firstNameController,
    );
  }

  Widget _lastNameField() {
    return NewTextField(
      hintText: 'Enter last name',
      controller: lastNameController,
    );
  }

  Widget _emailField() {
    return NewTextField(
      hintText: 'Enter email',
      controller: emailController,
    );
  }

  Widget _passwordField() {
    return TextField(
        keyboardType: TextInputType.text,
        controller: passwordController,
        obscureText: _passwordVisible,
        decoration: InputDecoration(
            hintText: 'Password',
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
            hintText: 'Confirm password',
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

  Widget _submitButton(Function pressed) {
    return NewButton(
      buttonText: 'Create Account',
      onTap: pressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, child) {
          {
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
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: screenSize.height),
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              NewHeaders(headerText: 'Create An Account'),
                              _firstNameField(),
                              SizedBox(height: 20),
                              _lastNameField(),
                              SizedBox(height: 20),
                              _emailField(),
                              SizedBox(height: 20),
                              _passwordField(),
                              SizedBox(height: 20),
                              _confirmPasswordField(),
                              SizedBox(height: 13),
                              CheckboxListTile(
                                dense: true,
                                activeColor: kPrimaryColor,
                                title: Text(
                                    'I read and agreed to Terms and Conditions'),
                                value: isChecked,
                                onChanged: (newValue) {
                                  setState(() {
                                    isChecked = newValue;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              SizedBox(height: 10),
                              _submitButton(() {
                                model.signup(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  lastname: lastNameController.text,
                                  firstname: firstNameController.text,
                                );
                              }),
                              SizedBox(height: 15),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Already have an account?',
                                        style: kUniversalTextStyle),
                                    SizedBox(width: 5),
                                    InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LogIn())),
                                        child: Text(
                                          'Sign in',
                                          style: kInkWellTextStyle,
                                        )),
                                  ]),
                              SizedBox(height: 31),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('or signup with',
                                      style: kUniversalTextStyle),
                                  NewInkWell(
                                      text: 'Google',
                                      icon: FontAwesomeIcons.google),
                                  NewInkWell(
                                      text: 'Github',
                                      icon: FontAwesomeIcons.github)
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                ));
          }
        });
  }
}
