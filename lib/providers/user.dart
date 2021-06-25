import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/models/userModel.dart';

class User with ChangeNotifier {
  List<UserModel> _userDetails = [
    UserModel(
      fName: 'Esther',
      imageUrl:
          'https://cdn.pixabay.com/photo/2015/08/11/21/39/smile-885243_640.jpg',
      lName: 'John',
      studentId: '001',
      bio: 'Abiola is a designer',
      emailAdd: 'denscholar2020@yahoomail.com',
    ),
    UserModel(
      fName: 'Esther',
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bWVufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
      lName: 'John',
      studentId: '002',
      bio: 'Abiola is a designer',
      emailAdd: 'denscholar2020@yahoomail.com',
    ),
    UserModel(
      fName: 'Esther',
      imageUrl:
          'https://media.istockphoto.com/photos/smiling-indian-man-looking-at-camera-picture-id1270067126?k=6&m=1270067126&s=612x612&w=0&h=m-n46eBmjQn-_XMkXuttqd-fFuFgV4qz1uAK_RkM6YM=',
      lName: 'John',
      studentId: '003',
      bio: 'Abiola is a designer',
      emailAdd: 'denscholar2020@yahoomail.com',
    ),
    UserModel(
      fName: 'Esther',
      imageUrl:
          'https://cdn.pixabay.com/photo/2015/08/11/21/39/smile-885243_640.jpg',
      lName: 'John',
      studentId: '004',
      bio: 'Abiola is a designer',
      emailAdd: 'denscholar2020@yahoomail.com',
    )
  ];

  List<UserModel> get userItems {
    return [..._userDetails];
  }
}
