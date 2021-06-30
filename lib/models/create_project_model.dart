import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';
import 'package:starthub_mobile_pjt/service/cloud_storage_service.dart';
import 'package:starthub_mobile_pjt/service/dialog_service.dart';
import 'package:starthub_mobile_pjt/service/firestore_service.dart';
import 'package:starthub_mobile_pjt/service/image_selector.dart';
import 'package:starthub_mobile_pjt/service/navigation_service.dart';

import '../locator.dart';
import 'base_model.dart';

class CreateProjectViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  File _selectedImage;
  File get selectedImage => _selectedImage;

  ProjectModel project;

  bool get _project => project != null;

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = File(tempImage.path);
      notifyListeners();
    }
  }

  Future addProject({@required String title}) async {
    setBusy(true);

    CloudStorageResult storageResult;

    if (!_project) {
      storageResult = await _cloudStorageService.uploadImage(
        imageToUpload: _selectedImage,
        title: title,
      );
    }

    var result;

    if (!_project) {
      result = await _firestoreService.createProject(ProjectModel(  projectId: project.projectId,
      projectName: title,
      projectInfo: project.projectInfo,
      imgUrl: project.imgUrl,
      projectOwners: project.projectOwners,
      tags: project.tags));
    } else {
      result = await _firestoreService.updateProject(ProjectModel(
        projectId: project.projectId,
      projectName: title,
      projectInfo: project.projectInfo,
      imgUrl: project.imgUrl,
      projectOwners: project.projectOwners,
      tags: project.tags
      ));
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Cound not create project',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Project successfully Added',
        description: 'Your project has been created',
      );
    }

    _navigationService.pop();
  }

  void setProject(ProjectModel project) {
    project = project;
  }
}