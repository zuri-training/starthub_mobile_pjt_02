import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';
import 'package:starthub_mobile_pjt/providers/projects.dart';
import 'package:starthub_mobile_pjt/widget/project_item.dart';
import 'package:provider/provider.dart';

class ProjectGrid extends StatelessWidget {
  final List<ProjectModel> projects;
  // final TextEditingController searchBar;
  ProjectGrid(this.projects);

  @override
  Widget build(BuildContext context) {
    // final projectData = Provider.of<Projects>(context);
    // final projects = projectData.items;
    return GridView.builder(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3/2,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) => ProjectItem(
        projects[index].projectName,
        projects[index].projectId,
        projects[index].imgUrl,
        projects[index].projectOwners,
        projects[index].tags,
      ),
      itemCount: projects.length,
    );
  }
}
