import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/models/project.dart';

import '../constants.dart';
import 'edit_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile View",
          style: TextStyle(
              color: kTextColor,
              fontFamily: kfont,
              fontWeight: FontWeight.bold),
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
                      'assets/images/starthub-logo-removebg-preview_1.png'),
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
              Container(child: ProjectList(
                items: projects,
              ),)
              
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
              '${number}',
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

class ProjectList extends StatelessWidget {
  const ProjectList({Key key, this.items}) : super(key: key);

  final List<Project> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ProjectBox(item: projects[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectView(item: projects[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class ProjectView extends StatelessWidget {
  ProjectView({Key key, this.item}) : super(key: key);

  final Project item;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Project Details",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: kfont,
                  fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                VerticalSpacing(
                  of: 0.03,
                ),
                Image.asset(
                  this.item.image,
                  width: size.width * 0.5,
                  height: size.height * 0.2,
                  fit: BoxFit.cover,
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Name: ' + this.item.internName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('projectName: ' + this.item.projectName),
                          ],
                        ))),
                Divider()
              ]),
        ));
  }
}

class ProjectBox extends StatelessWidget {
  ProjectBox({Key key, this.item}) : super(key: key);
  final Project item;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.45,
        width: size.width * 0.9,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(children: [
          Container(
            width: size.width * 0.9,
            height: size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              image: DecorationImage(
                  image: AssetImage(this.item.image), fit: BoxFit.fill),
            ),
          ),
          Container(
              width: size.width * 0.9,
              height: size.height * 0.15,
              decoration: BoxDecoration(boxShadow: [kDefualtShadow]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    this.item.projectName,
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: kfont,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    this.item.internName,
                    style: TextStyle(fontSize: 15, color: kPrimaryColor),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15),
                            right: Radius.circular(15)),
                        border: Border.all(color: kPrimaryColor, width: 1.5)),
                    child: Text(
                      this.item.track,
                      style: TextStyle(fontSize: 15, color: kPrimaryColor),
                    ),
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}
