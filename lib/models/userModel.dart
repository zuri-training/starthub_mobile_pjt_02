import 'package:flutter/material.dart';
// import 'package:starthub_mobile_pjt/models/projectModel.dart';

class UserModel {
  final String fName;
  final String lName;
  final String studentId;
  final String emailAdd;
  final String imageUrl;
  final String bio;


  UserModel({
    @required this.fName,
    @required this.lName,
    @required this.imageUrl,
    @required this.bio,
    @required this.emailAdd,
    @required this.studentId,

  });
}
