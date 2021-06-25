import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/providers/projects.dart';
import 'package:starthub_mobile_pjt/widget/project_item.dart';
import 'package:provider/provider.dart';

class ProjectGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectData = Provider.of<Projects>(context);
    final project = projectData.items;
    return GridView.builder(
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
    );
  }
}
