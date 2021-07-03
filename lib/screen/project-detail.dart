import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:starthub_mobile_pjt/providers/projects.dart';
import 'package:starthub_mobile_pjt/providers/user.dart';

import '../constants.dart';

class ProjectDetailScreen extends StatelessWidget {
  static const routeName = 'project-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String; // is the id
    final loadedProject = Provider.of<Projects>(context).items.firstWhere(
          (project) => project.projectId == id,
        );
    final loadedUser = Provider.of<Users>(context)
        .userItems
        .firstWhere((student) => student.studentId == id);
    // final int index = 0;
    // print(loadedUser[index].project.projectId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(loadedProject.projectName),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 35.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(loadedUser.imageUrl),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              (loadedProject.projectOwners),
              style: GoogleFonts.inter(
                fontSize: 16.0,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(
              height: 3.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loadedProject.tags,
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    loadedUser.emailAdd,
                    style: GoogleFonts.inter(
                      fontSize: 14.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                      child: Text(
                    loadedProject.projectName,
                    style: GoogleFonts.inter(
                      fontSize: 20.0,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        loadedProject.imgUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'About',
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: GoogleFonts.inter(fontSize: 14.0, color: Colors.black),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 180.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            loadedProject.imgUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            height: 85.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                loadedProject.imgUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            child: Container(
                              height: 85.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  loadedProject.imgUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Follow ${loadedUser.fName} on:',
                        style: GoogleFonts.inter(
                            fontSize: 14.0, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              icon: Icon(FontAwesomeIcons.facebook),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(FontAwesomeIcons.twitter),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(FontAwesomeIcons.instagram),
                              onPressed: () {}),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
