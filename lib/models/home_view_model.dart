import 'package:starthub_mobile_pjt/models/projectModel.dart';
import 'package:starthub_mobile_pjt/service/cloud_storage_service.dart';
import 'package:starthub_mobile_pjt/service/dialog_service.dart';
import 'package:starthub_mobile_pjt/service/firestore_service.dart';
import 'package:starthub_mobile_pjt/service/navigation_service.dart';
import 'package:starthub_mobile_pjt/widget/route_name.dart';

import '../locator.dart';
import 'base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  List<ProjectModel> _project;
  List<ProjectModel> get project => _project;

  void listenToProject() {
    setBusy(true);

    _firestoreService.listenToProject().listen((projectData) {
      List<ProjectModel> updatedProject = projectData;
      if (updatedProject != null && updatedProject.length > 0) {
        _project = updatedProject;
        notifyListeners();
      }

      setBusy(false);
    });
  }

  Future deleteProject(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the project?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      var projectToDelete = _project[index];
      setBusy(true);
      await _firestoreService.deleteProject(projectToDelete);
      // Delete the image after the projectProjectModel is deleted
      await _cloudStorageService.deleteImage(projectToDelete.imgUrl);
      setBusy(false);
    }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreateProjectViewRoute);
  }

  void editProjectModel(int index) {
    _navigationService.navigateTo(CreateProjectViewRoute,
        arguments: _project[index]);
  }
}