import 'package:flutter/material.dart';

import 'package:starthub_mobile_pjt/screens/profile.dart';

import '../constants.dart';

class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        elevation: 0,
        title: Text(
          "Welcome",
          style: TextStyle(
              color: kPrimaryColor,
              fontFamily: kfont,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SearchBox();
                    },
                  ));
                },
                child: Icon(
                  Icons.search_rounded,
                  color: kPrimaryColor,
                ),
              )
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(color: kBackground),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                child: Text(
                  'Sign up to showcase your project',
                  style: TextStyle(
                      color: kPrimaryColor, fontFamily: kfont, fontSize: 15),
                ),
              ),
              VerticalSpacing(),
              SingleChildScrollView(
                child: ProjectList(
                  items: projects,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: "Search for Projects",
          hintStyle: TextStyle(
            fontSize: 15,
            color: Color(0xFFBDBDBD),
          ),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
