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

  Future createProject(ProjectModel project) async {
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

  Future updateProject(String uid,String studentId,String firstname,String lastname, String imageUrl, String bio) async {
    try {
      await _projectCollectionReference.doc(uid).update({
      "studentId": studentId,
      "fName": firstname,
      "lName": lastname,
      "imageUrl": imageUrl,
      "bio": bio,
    });
      
    } catch (e) {
      return e.message;
    }
  }

  Future deleteProject(String uid) async {
    try {
      return await _projectCollectionReference.doc(uid).delete();
    } catch (e) {
      return e.message;
    }
  }
}
