import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
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
  File _image;
  final _picker = ImagePicker();
  FirestoreService firestoreService;

  TextEditingController fnameController = new TextEditingController();
  TextEditingController lnameController = new TextEditingController();
  TextEditingController websiteController = new TextEditingController();
  TextEditingController bioController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

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
      _image = image as File;
    });
  }

  Future _imgFromGallery() async {
    PickedFile image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image as File;
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
        body: Container(
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
                                _image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
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
                    controller: fnameController,
                    validator: (value) =>
                        value.isNotEmpty ? null : "Cannot be empty",
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
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
                    controller: lnameController,
                    validator: (value) =>
                        value.isNotEmpty ? null : "Cannot be empty",
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      hintText: 'Last Name',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Text(
                  'Email Address',
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
                    controller: emailController,
                    validator: (value) =>
                        value.isNotEmpty ? null : "Cannot be empty",
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      hintText: 'Email Address',
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
                    controller: bioController,
                    validator: (value) =>
                        value.isNotEmpty ? null : "Cannot be empty",
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      hintText: 'Bio',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Text(
                  'Website/Link',
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
                    controller: websiteController,
                    validator: (value) =>
                        value.isNotEmpty ? null : "Cannot be empty",
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      hintText: 'Website/Link',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                RoundedButton(
                  text: "Update Profile",
                  color: kPrimaryColor,
                  textColor: Colors.white,
                  press: () async {
                    if (!isValidFirstName(fnameController.text)) {
                      Fluttertoast.showToast(
                        msg: "firstname is not valid",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (!isValidLastName(lnameController.text)) {
                      Fluttertoast.showToast(
                        msg: "lastname is not valid",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (!isValidEmail(emailController.text)) {
                      Fluttertoast.showToast(
                        msg: "Please check your email address again",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else {
                      print("updating profile");
                      CircularProgressIndicator(strokeWidth: 2,valueColor: AlwaysStoppedAnimation<Color>(kBackground),);

                      var result = await firestoreService.updateUser(UserModel(
                          fName: fnameController.text,
                          lName: lnameController.text,
                          emailAdd: emailController.text,
                          bio: bioController.text,
                          imageUrl: _image.toString()));
                      if (result == null) {
                        return Container(
                          color: Colors.amber,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        )
      );
  }
}
