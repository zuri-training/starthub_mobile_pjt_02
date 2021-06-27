import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';

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
     this.imageUrl,
     this.bio,
    @required this.emailAdd,
    @required this.studentId,
  });

  UserModel.fromData(Map<String, dynamic> data)
      : studentId = data['studentId'],
        fName = data['firstname'],
        lName = data['lastname'],
        imageUrl = data['imageUrl'],
        bio = data['bio'],
        emailAdd = data['emailAdd'];

    Map<String, dynamic> toJson() {
    return {
      studentId: 'studentId',
      fName: 'firstname',
      lName: 'lastname',
      imageUrl: 'imageUrl',
      bio: 'bio',
      emailAdd: 'emailAdd'
    };
  }
}
