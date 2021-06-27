import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';
import 'package:starthub_mobile_pjt/models/userModel.dart';
import 'package:starthub_mobile_pjt/providers/user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _projectCollectionReference =
      FirebaseFirestore.instance.collection('projects');

  Future createUser(UserModel user) async {
    try {
      return await _usersCollectionReference.doc(user.studentId).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String studentId) async {
    try {
      var userData = await _usersCollectionReference.doc(studentId).get();
      return UserModel.fromData(userData.data());
    } catch (e) {
      return e.message;
    }
  }
  Future updateUser(UserModel user) async {
    try {
      return await _usersCollectionReference.doc(user.studentId).update({

      "fName": user.fName,
      "lName": user.lName,
      "imageUrl": user.imageUrl,
      "bio": user.bio,
      'emailAdd':user.emailAdd,
    });
      
    } catch (e) {
      return e.message;
    }
  }

  Future createProject(ProjectModel project) async {
    try {
      return await _projectCollectionReference.doc(project.projectId).set(project.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getProject(ProjectModel project) async {
    try {
      var projectData = await _projectCollectionReference.doc(project.projectId).get();
      return UserModel.fromData(projectData.data());
    } catch (e) {
      return e.message;
    }
  }

  Future updateProject(ProjectModel project) async {
    try {
      return await _projectCollectionReference.doc(project.projectId).update({
      'projectName': project.projectName,
      "projectInfo": project.projectInfo,
      'imgUrl': project.imgUrl,
      'projectOwners': project.projectOwners,
      'tags': project.tags
    });
      
    } catch (e) {
      return e.message;
    }
  }

  Future deleteProject(ProjectModel project) async {
    try {
      return await _projectCollectionReference.doc(project.projectId).delete();
    } catch (e) {
      return e.message;
    }
  }
}
