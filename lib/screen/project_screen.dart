import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';
import 'package:starthub_mobile_pjt/widget/project_item.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  List<ProjectModel> project = [
    ProjectModel(
      projectName: 'Crypto Trade App',
      projectId: '001',
      projectInfo: 'This project is for starthub interns',
      imgUrl:
          'https://cdn.dribbble.com/users/551602/screenshots/12050075/media/e8722552bc13c2e1a170905c90a14db7.png?compress=1&resize=400x300',
      projectOwners: 'James & John Doe',
      tags: 'Frontend',
    ),
    ProjectModel(
      projectName: 'Free Fitness/Workout App',
      projectId: '001',
      projectInfo: 'This project is for starthub interns',
      imgUrl:
          'https://xdfile.com/wp-content/uploads/2020/03/workout-free-xd-app-ui-kit-758x364.jpg',
      projectOwners: 'John Doe',
      tags: 'Frontend',
    ),
    ProjectModel(
      projectName: 'Smart Learning App',
      projectId: '001',
      projectInfo: 'This project is for starthub interns',
      imgUrl:
          'https://assets.materialup.com/uploads/248bd07c-db1f-4d81-be27-81bd66305749/preview.png',
      projectOwners: 'James & John Doe',
      tags: 'Backend',
    ),
    ProjectModel(
      projectName: 'StartHub',
      projectId: '001',
      projectInfo: 'This project is for starthub interns',
      imgUrl:
          'https://cdn.dribbble.com/users/551602/screenshots/12050075/media/e8722552bc13c2e1a170905c90a14db7.png?compress=1&resize=400x300',
      projectOwners: 'James & John Doe',
      tags: 'Design',
    ),
  ];
  Icon customIcon = Icon(Icons.search);

  Widget customText = Text(
    'Welcome!',
    style: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
  );

  void toggleSearch() {
    setState(() {
      if (customIcon.icon == Icons.search) {
        customIcon = Icon(Icons.cancel);
        customText = Container(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 10.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Seacrh for project/intern',
                  hintStyle: TextStyle(fontSize: 17.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              textAlign: TextAlign.center,
              autofocus: true,
              textInputAction: TextInputAction.go,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),
        );
      } else {
        this.customIcon = Icon(Icons.search);
        this.customText = Text(
          'Welcome!',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 30, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: customText),
                  IconButton(icon: customIcon, onPressed: toggleSearch)
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  'Signup to showcase your project!',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) => ProjectItem(
                  project[index].projectName,
                  project[index].projectId,
                  project[index].imgUrl,
                  project[index].projectOwners,
                  project[index].tags,
                ),
                itemCount: project.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
