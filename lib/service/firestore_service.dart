import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';
import 'package:starthub_mobile_pjt/models/userModel.dart';

class FirestoreService {
  final String uid;
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference _projectCollectionReference =
      FirebaseFirestore.instance.collection('project');
  final StreamController<List<ProjectModel>> _projectController =
      StreamController<List<ProjectModel>>.broadcast();

  FirestoreService({this.uid});

  Future createUser(String fName, String lName, String imageUrl, String bio,
      String email, String password) async {
    return await _usersCollectionReference.doc(uid).set({
      "studentId": uid,
      'firstname': fName,
      'lastname': lName,
      'imageUrl': imageUrl,
      'bio': bio,
      'email': email,
      'password': password
    });
  }

  Future getUser(String studentId) async {
    try {
      var userData = await _usersCollectionReference.doc(studentId).get();
      return UserModel.fromData(userData.data());
    } catch (e) {
      if (e is PlatformException) {
        return e.toString();
      }
      return e.toString();
    }
  }

  Future updateUser(UserModel user) async {
    try {
      return await _usersCollectionReference.doc(user.studentId).update({
        "studentId": user.studentId,
        'firstName': user.fName,
        'lastName': user.lName,
        'imageUrl': user.imageUrl,
        'bio': user.bio,
        'emailAdd': user.emailAdd
      });
    } catch (e) {
      if (e is PlatformException) {
        return e.toString();
      }
      return e.toString();
    }
  }

  Future createProject(ProjectModel project) async {
    try {
      return await _projectCollectionReference
          .doc(project.projectId.toString())
          .set({
        'projectId': project.projectId,
        'projectName': project.projectName,
        'projectInfo': project.projectInfo,
        'imgUrl': project.imgUrl,
        'projectOwners': project.projectOwners,
        'tags': project.tags
      });
    } catch (e) {
      if (e is PlatformException) {
        return e.toString();
      }
      return e.toString();
    }
  }

  Future getProject() async {
    try {
      var projectDocumentSnapshot = await _projectCollectionReference.get();
      if (projectDocumentSnapshot.docs.isNotEmpty) {
        return projectDocumentSnapshot.docs
            .map((snapshot) =>
                ProjectModel.fromData(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem.projectName != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.toString();
      }
      return e.toString();
    }
  }

  Future updateProject(ProjectModel project) async {
    try {
      return await _projectCollectionReference.doc(project.projectId).update({
        'projectId': project.projectId,
        'projectName': project.projectName,
        'projectInfo': project.projectInfo,
        'imgUrl': project.imgUrl,
        'projectOwners': project.projectOwners,
        'tags': project.tags
      });
    } catch (e) {
      if (e is PlatformException) {
        return e.toString();
      }
      return e.toString();
    }
  }

  Future deleteProject(ProjectModel project) async {
    try {
      return await _projectCollectionReference.doc(project.projectId).delete();
    } catch (e) {
      if (e is PlatformException) {
        return e.toString();
      }
      return e.toString();
    }
  }

  Stream<List<ProjectModel>> listenToProject() {
    _projectCollectionReference.snapshots().listen((projectsSnapshot) {
      if (projectsSnapshot.docs.isNotEmpty) {
        var projects = projectsSnapshot.docs
            .map((snapshot) =>
                ProjectModel.fromData(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem.projectName != null)
            .toList();
        _projectController.add(projects);
      }
    });

    return _projectController.stream;
  }

  //usermodel from snapshot
  UserModel _userModelFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      studentId: uid,
      emailAdd: snapshot.get('email'),
      fName: snapshot.get('firstname'),
      lName: snapshot.get('lastname'),
      bio: snapshot.get('bio'),
      imageUrl: snapshot.get('imageUrl'),
      
    );
  }

  //get user doc stream
  Stream<UserModel> get listenToUser {
    return _usersCollectionReference
        .doc(uid)
        .snapshots()
        .map(_userModelFromSnapshot);
  }
}
