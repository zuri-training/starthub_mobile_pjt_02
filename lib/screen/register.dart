import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starthub_mobile_pjt/service/authentication.dart';
import 'package:starthub_mobile_pjt/service/dialog_service.dart';
import 'package:starthub_mobile_pjt/service/navigation_service.dart';

import '../constants.dart';
import '../locator.dart';
import '../widget/presets.dart';


class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final DialogService _dialogService = locator<DialogService>();
  bool isChecked = false;
  final _formkey = GlobalKey<FormState>();
  bool _passwordVisible;
  final provider = AuthService();
  TextEditingController passwordController;
  TextEditingController emailController;
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController _confirmUserPasswordController;

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
    return TextFormField(
        keyboardType: TextInputType.text,
        controller: passwordController,
        obscureText: _passwordVisible,
        validator: (value) => value.length < 6 ? "Cannot be less than 6 chars" : null,
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
    return TextFormField(
        keyboardType: TextInputType.text,
        controller: _confirmUserPasswordController,
        obscureText: _passwordVisible,
        validator: (value) => value.length < 6 ? "Cannot be less than 6 chars" : null,
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

  Widget _submitButton({Function pressed}) {
    return NewButton(
      buttonText: 'Create Account',
      onTap: pressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    
    Size screenSize = MediaQuery.of(context).size;
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
                          title:
                              Text('I read and agreed to Terms and Conditions'),
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
                        _submitButton(pressed: () async {
                          if (_formkey.currentState.validate()) {
                            print("Email Address: ${emailController.text}" +
                                ' | ' +
                                "Password: ${passwordController.text}");
                            dynamic result = await provider.register(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                firstname: firstNameController.text.trim(),
                                lastname: lastNameController.text.trim());
                            if (result == null) {
                              return _dialogService.showDialog(
                                  title: "Register Failure",
                                  description:
                                      'General Register failure. Please try again later');
                            }
                          }
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
                                          builder: (context) => Register())),
                                  child: Text(
                                    'Sign in',
                                    style: kInkWellTextStyle,
                                  )),
                            ]),
                        SizedBox(height: 31),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('or Register with', style: kUniversalTextStyle),
                            NewInkWell(
                                text: 'Google', icon: FontAwesomeIcons.google),
                            NewInkWell(
                                text: 'Github', icon: FontAwesomeIcons.github)
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }
}
