import 'package:flutter/material.dart';
// import 'package:starthub_mobile_pjt/models/projectModel.dart';

class UserModel {
  final String fName;
  final String lName;
  final String studentId;
  final String emailAdd;
  final String imageUrl;
  final String bio;
  final String link;
  final String password;

  UserModel({
    @required this.fName,
    @required this.lName,
    this.imageUrl,
    this.password, 
    this.link,
    this.bio,
    @required this.emailAdd,
    this.studentId,
  });

  UserModel.fromData(Map<String, String> data)
      : studentId = data['studentId'],
        fName = data['firstname'],
        lName = data['lastname'],
        link = data['link'],
        imageUrl = data['imageUrl'],
        bio = data['bio'],
        emailAdd = data['emailAdd'],
        password = data['password'];

  Map<String, String> toJson() {
    return {
      studentId: 'studentId',
      fName: 'firstname',
      lName: 'lastname',
      imageUrl: 'imageUrl',
      bio: 'bio',
      link: 'link',
      emailAdd: 'emailAdd',
      password:'password'
    };
  }
}
