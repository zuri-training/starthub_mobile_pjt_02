import 'package:flutter/material.dart';

class Project {
  final String internName, image;
  final String projectName;
  final String track;

  Project({
    @required this.projectName,
    @required this.internName,
    @required this.image,
    @required this.track,
  });
}

List<Project> projects = [

  Project(
    projectName: "Crypto Trade App",
    internName: "John Doe & Elizabeth Remi",
    image: "assets/images/crytoApp.svg",
    track: "Design",
  ),
  Project(
    projectName: "ChatBot Website",
    internName: "Mary Ashe, Michael Isum & Akin Doe",
    image: "assets/images/chatBot.svg",
    track: 'Frontend',
  ),
  Project(
    projectName: "Weather App",
    internName: "Akinseye Olote & Dan James",
    image: "assets/images/weatherApp.svg",
    track: 'Backend',
  ),
];
