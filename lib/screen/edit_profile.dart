import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:starthub_mobile_pjt/models/userModel.dart';
import 'package:starthub_mobile_pjt/screen/profile.dart';
import 'package:starthub_mobile_pjt/service/firestore_service.dart';
import '../constants.dart';

class EditProfile extends StatefulWidget {
  EditProfile();

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  PickedFile _image;
  final _picker = ImagePicker();
  FirestoreService firestoreService;
  final _formkey = GlobalKey<FormState>();
  String fnameController;
  String lnameController;
  String websiteController;
  String bioController;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: kPrimaryColor));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static bool isValidEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  static bool isValidFirstName(String firstName) {
    bool b = false;
    if (firstName.length < 1) {
      b = false;
    } else {
      b = true;
    }
    return b;
  }

  static bool isValidLastName(String lastName) {
    bool b = false;
    if (lastName.length < 1) {
      b = false;
    } else {
      b = true;
    }
    return b;
  }

  Future _imgFromCamera() async {
    PickedFile image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  Future _imgFromGallery() async {
    PickedFile image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<User>(context);
    return StreamBuilder<UserModel>(
        stream: FirestoreService(uid: user.uid).listenToUser,
        builder: (context, snapshot) {
          UserModel userModel = snapshot.data;

          return Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: kFont,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                backgroundColor: kPrimaryColor,
                elevation: 1,
              ),
              body: Form(
                key: _formkey,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(color: kBackground),
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerticalSpacing(of: 0.03),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: kBackground,
                              child: _image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.file(
                                        File(_image.path),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 100,
                                      height: 100,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Text(
                          'First Name',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextFormField(
                            initialValue: userModel.fName,
                            validator: (value) =>
                                value.isNotEmpty ? null : "Cannot be empty",
                            onChanged: (value) =>
                                setState(() => fnameController = value),
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              hintText: 'First Name',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Text(
                          'Last Name',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextFormField(
                            initialValue: userModel.lName,
                            validator: (value) =>
                                value.isNotEmpty ? null : "Cannot be empty",
                            onChanged: (value) =>
                                setState(() => lnameController = value),
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              hintText: 'Last Name',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Text(
                          'Bio',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextFormField(
                            initialValue: userModel.bio,
                            validator: (value) =>
                                value.isNotEmpty ? null : "Cannot be empty",
                            onChanged: (value) =>
                                setState(() => bioController = value),
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              hintText: 'Bio',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Text(
                          'Github Link',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextFormField(
                            initialValue: userModel.link,
                            validator: (value) =>
                                value.isNotEmpty ? null : "Cannot be empty",
                            onChanged: (value) =>
                                setState(() => websiteController = value),
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              hintText: 'Input your Github Username without @',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        RoundedButton(
                            text: "Update Profile",
                            color: kPrimaryColor,
                            textColor: Colors.white,
                            press: () async {
                              if (_formkey.currentState.validate()) {
                                
                                  print("updating profile");

                                  dynamic result = await FirestoreService(
                                          uid: user.uid)
                                      .createUser(
                                          fName: fnameController ??
                                              userModel.fName,
                                          lName: lnameController ??
                                              userModel.lName,
                                          bio: bioController ?? userModel.bio,
                                          imageUrl:
                                              _image.path ?? userModel.imageUrl,
                                          link: 'https://github.com/' +
                                                  websiteController ??
                                              userModel.link,
                                              email: userModel.emailAdd,
                                              password: userModel.password);
                                  print('result: $result');
                                  if (result == null) {
                                    return Container(
                                      color: Colors.amber,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: ListTile(
                                        title: Text("fill the empty boxes"),
                                        leading: Icon(Icons.error),
                                        trailing: IconButton(
                                            onPressed: () {
                                              // Authenticate();
                                            },
                                            icon: Icon(Icons.close)),
                                      ),
                                    );
                                  } else {
                                    Navigator.pop(context);
                                  }
                                }
                              
                            }),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
