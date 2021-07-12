import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:starthub_mobile_pjt/models/signup_view_model.dart';
import 'package:starthub_mobile_pjt/widget/presets.dart';

import '../constants.dart';

import 'login_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isChecked = false;
  final _formkey = GlobalKey<FormState>();
  bool _passwordVisible;
  TextEditingController passwordController;
  TextEditingController emailController;
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController _confirmUserPasswordController;

  get kOrLoginTextStyle => null;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
    passwordController = TextEditingController();
    emailController = TextEditingController();
    _confirmUserPasswordController = TextEditingController();
    lastNameController = TextEditingController();
    firstNameController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    _confirmUserPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
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

  Widget _submitButton({bool busy, Function pressed}) {
    return NewButton(
      buttonText: 'Create Account',
      onTap: pressed,
      busy: busy,
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
                
                body: SafeArea(
                  child: Form(
                    key: _formkey,
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
                                _submitButton(
                                    busy: model.busy,
                                    pressed: () {
                                      if (_formkey.currentState.validate()) {
                                        _formkey.currentState.save();
                                        print(
                                            "Email Address: ${emailController.text}");
                                        print(
                                            "Password: ${passwordController.text}");
                                        model.signup(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                          lastname:
                                              lastNameController.text.trim(),
                                          firstname:
                                              firstNameController.text.trim(),
                                        );
                                      }
                                    }),
                                SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Already have an account?',
                                          style: kOrLoginTextStyle),
                                      SizedBox(width: 5),
                                      InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LogIn())),
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
                                        style: kOrLoginTextStyle),
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
                  ),
                ));
          }
        });
  }
}
