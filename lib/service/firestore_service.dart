import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';
import 'package:starthub_mobile_pjt/models/userModel.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _projectCollectionReference =
      FirebaseFirestore.instance.collection('project');
  final StreamController<List<ProjectModel>> _projectController =
      StreamController<List<ProjectModel>>.broadcast();

    createUser(UserModel users) {
    try {
     _usersCollectionReference.doc(users.studentId).set(users.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.toString();
      }
      return e.toString();
    }
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
      return await _usersCollectionReference
          .doc(user.studentId)
          .update(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.toString();
      }
      return e.toString();
    }
  }

  Future createProject(ProjectModel project) async {
    try {
      return await _projectCollectionReference.add(project.toJson());
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
      return await _projectCollectionReference
          .doc(project.projectId)
          .update(project.toJson());
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

  Stream listenToProject() {
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
}
