import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/constants.dart';

class CreateProject extends StatefulWidget {
  CreateProject({Key key}) : super(key: key);

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: CircularProgressIndicator(strokeWidth: 2,valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)),
    );
  }
}