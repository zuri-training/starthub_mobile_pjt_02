import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starthub_mobile_pjt/authentication/sign_in.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';
import 'package:starthub_mobile_pjt/models/userModel.dart';
import 'package:starthub_mobile_pjt/screen/home.dart';
import 'package:starthub_mobile_pjt/service/authentication.dart';
import 'package:starthub_mobile_pjt/service/firestore_service.dart';
import 'package:starthub_mobile_pjt/widget/loading.dart';
import 'package:starthub_mobile_pjt/widget/project_grid.dart';

import '../constants.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<User>(context);
    // print('user: $user');

    

    Future <Null> showLogout(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return SimpleDialog(
          semanticLabel: 'Log out',
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: <Widget>[
              new Text(
                'Log out',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 22
                ),
              ),
              VerticalSpacing(),
              Text.rich(
                TextSpan(
                  text: "Are you sure you want to log out? \n If you do, all your details will be cleared and restored when you log back in.",
                
                ),
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "SourceSansPro-Light"
                ),
                textAlign: TextAlign.center,
              ),
              VerticalSpacing(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    elevation: 10,
                    child: Text('No',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "WorkSansMedium",
                      fontSize: 18
                    ),),
                    color: Colors.white,
                    onPressed: (){
                      print('Cancel');
                      Navigator.pop(context);
                    },
                  ),
                  VerticalSpacing(),
                  RaisedButton(
                    elevation: 10,
                    child: Text('Yes',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontFamily: "WorkSansMedium",
                      fontSize: 18
                    ),),
                    color: Colors.white,
                    onPressed: ()async{
                      await AuthService().logout();
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          
        );
      }
    );
  }
  void _overflow(OverflowItem selected) {
    switch (selected) {

      case OverflowItem.EditProfile:
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new EditProfile(),
          ),
        );
        break;
      case OverflowItem.LogOut:
        showLogout(context);
        break;
    }
    }

    Widget _simplePopup() => PopupMenuButton<OverflowItem>(
          onSelected: _overflow,
          icon: Icon(
            FontAwesomeIcons.ellipsisV,
            color: Colors.white,
          ),
          itemBuilder: (context) => [
            new PopupMenuItem(
                value: OverflowItem.EditProfile,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.solidEdit,
                      color: kPrimaryColor,
                      size: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:  7,
                            vertical: 15)),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontFamily: "SourceSansPro-Light",
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            new PopupMenuItem<OverflowItem>(
                value: OverflowItem.LogOut,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: Colors.redAccent,
                      size: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 15)),
                    Text(
                      'Logout',
                      style: TextStyle(
                          fontFamily: "SourceSansPro-Light",
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ))
          ],
        );

    return StreamBuilder<UserModel>(
        stream: FirestoreService(uid: user.uid).listenToUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userModel = snapshot.data;

            return SafeArea(
              child: Scaffold(
                key: _scaffoldKey,
                body: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.06,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(color: kPrimaryColor),
                      child: Padding(
                        padding: EdgeInsets.only(
                             left: 5, right: 5.0, ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Icon(FontAwesomeIcons.arrowLeft,
                                  color: Colors.white),
                              onTap: () {
                                print("back pressed");
                                Navigator.pop(context);
                              },
                            ),
                            Text(
                              "Profile".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: kFont,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Image.asset(
                            //     'assets/images/starthub-logo-removebg-preview_1.png',
                            //     width: size.width * 0.3,
                            //     height: size.height * 0.1),
                            _simplePopup(),
                            
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                                          child: SingleChildScrollView(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(color: kBackground),
                          height: size.height,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: size.width,
                                  height: size.height * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: kPrimaryColor,
                                  ),
                                  child: Column(children: [
                                    VerticalSpacing(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: userModel.imageUrl != null
                                          ? ClipOval(
                                              child: Image.file(
                                              File(userModel.imageUrl),
                                              width: size.width * 0.25,
                                              height: size.height * 0.12,
                                              fit: BoxFit.cover,
                                            ))
                                          : CircleAvatar(
                                            radius: 7,
                                            child: Text(userModel.fName.substring(0,1).toUpperCase()),
                                              backgroundColor: kPrimaryColor,
                                            ),
                                    ),
                                    Text(
                                      userModel.fName + ' ' + userModel.lName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    VerticalDivider(),
                                    Text(
                                      userModel.emailAdd,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    VerticalSpacing(),
                                    Text(
                                      userModel.bio,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    NavItem(
                                        title: 'Projects',
                                        press: () {},
                                        number: 26),
                                    NavItem(
                                        title: 'Reviews',
                                        press: () {},
                                        number: 25),
                                  ],
                                ),
                                Divider(),

                                // ProjectGrid(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
              ),
              
            );
          } else {
            return LoadingWidget();
          }
        });
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    Key key,
    @required this.title,
    @required this.press,
    @required this.number,
    this.isActive = false,
  }) : super(key: key);
  final String title;
  final GestureTapCallback press;
  final bool isActive;
  final int number;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(5),
        width: size.width * 0.2,
        height: size.height * 0.07,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              number.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum OverflowItem {
  EditProfile,
  // PaymentHistory,
  
  LogOut
}
