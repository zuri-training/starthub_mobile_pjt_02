import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';

class Projects with ChangeNotifier {
  List<ProjectModel> _item = [
    ProjectModel(
      projectName: 'Crypto Trade App',
      projectId: '001',
      projectInfo: 'This project is for starthub interns',
      imgUrl:
          'https://cdn.dribbble.com/users/551602/screenshots/12050075/media/e8722552bc13c2e1a170905c90a14db7.png?compress=1&resize=400x300',
      projectOwners: 'John Doe',
      tags: 'Frontend',
    ),
    ProjectModel(
      projectName: 'Free Fitness/Workout App',
      projectId: '002',
      projectInfo: 'This project is for starthub interns',
      imgUrl:
          'https://xdfile.com/wp-content/uploads/2020/03/workout-free-xd-app-ui-kit-758x364.jpg',
      projectOwners: 'Felix Python',
      tags: 'Frontend',
    ),
    ProjectModel(
      projectName: 'Smart Learning App',
      projectId: '003',
      projectInfo: 'This project is for starthub interns',
      imgUrl:
          'https://assets.materialup.com/uploads/248bd07c-db1f-4d81-be27-81bd66305749/preview.png',
      projectOwners: 'James Philips',
      tags: 'Backend',
    ),
    ProjectModel(
      projectName: 'StartHub',
      projectId: '004',
      projectInfo: 'This project is for starthub interns',
      imgUrl:
          'https://cdn.dribbble.com/users/551602/screenshots/12050075/media/e8722552bc13c2e1a170905c90a14db7.png?compress=1&resize=400x300',
      projectOwners: 'Esther James',
      tags: 'Design',
    ),
  ];

  List<ProjectModel> get items {
    return [..._item];
  }
//search method
  List<ProjectModel> searchQuery(String searchText) {
    List searchItem = items
        .where((proj) =>
            proj.projectOwners.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return searchItem;
  }
}

