import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';
import 'package:starthub_mobile_pjt/models/userModel.dart';
import 'package:starthub_mobile_pjt/providers/user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _projectCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future _createUser(UserModel user) async {
    try {
      await _usersCollectionReference.doc(user.studentId).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return UserModel.fromData(userData.data());
    } catch (e) {
      return e.message;
    }
  }

  Future _createProject(ProjectModel project) async {
    try {
      await _projectCollectionReference.doc(project.projectId).set(project.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getProject(String uid) async {
    try {
      var projectData = await _projectCollectionReference.doc(uid).get();
      return UserModel.fromData(projectData.data());
    } catch (e) {
      return e.message;
    }
  }

  Future updateProject(String uid) async {
    try {
      await _projectCollectionReference.doc(uid).update();
      
    } catch (e) {
      return e.message;
    }
  }

  Future deleteProject(String uid) async {
    try {
      var projectData = await _projectCollectionReference.doc(uid).get();
      return UserModel.fromData(projectData.data());
    } catch (e) {
      return e.message;
    }
  }
}
