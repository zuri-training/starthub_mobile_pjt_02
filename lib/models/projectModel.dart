// enum StackTag { design, frontend, backend, mobile }

class ProjectModel {
  final String projectName;
  final String projectId;
  final String projectInfo;
  final String imgUrl;
  final String projectOwners;
  final String tags;

  ProjectModel({
    this.projectName,
    this.projectId,
    this.projectInfo,
    this.imgUrl,
    this.projectOwners,
    this.tags,
  });
}
