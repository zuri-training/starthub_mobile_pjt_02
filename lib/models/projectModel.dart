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
  ProjectModel.fromData(Map<String, dynamic> data, String projectId)
      : projectName = data['projectName'],
        projectInfo = data['projectInfo'],
        imgUrl = data['imgUrl'],
        projectOwners = data['projectOwners'],
        tags = data['tags'],
        projectId = projectId;

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'projectName': projectName,
      'projectInfo': projectInfo,
      'imgUrl': imgUrl,
      'projectOwners': projectOwners,
      'tags': tags
    };
  }
}
