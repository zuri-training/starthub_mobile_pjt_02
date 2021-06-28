import 'dart:ui';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Profile View",
            style: TextStyle(
                color: kTextColor,
                fontFamily: kFont,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: kBackground,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(color: kBackground),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                      'assets/images/starthub-logo-removebg-preview_1.png',
                      width: size.width*0.3,
                      height: size.height*0.1),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: kPrimaryColor)),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return EditProfile();
                          }));
                        },
                        child: Row(children: [
                          Icon(Icons.add, color: kTextColor),
                          Text(
                            'Edit Profile',
                            style: TextStyle(color: kTextColor),
                          )
                        ])),
                  )
                ],
              ),
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
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/dammy.JPG",
                        width: size.width * 0.25,
                        height: size.height * 0.14,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Text(
                    "Intern name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  VerticalDivider(),
                  const Text(
                    "intern@starthub.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  VerticalSpacing(),
                  Text(
                    "Hello World",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavItem(title: 'Projects', press: () {}, number: 26),
                  NavItem(title: 'Reviews', press: () {}, number: 25),
                  NavItem(title: 'Contacted', press: () {}, number: 26),
                ],
              ),
              Divider(),
              
              // ProjectGrid(),
              
            ],
          ),
        ),
      ),
    );
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

