import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';
import 'package:starthub_mobile_pjt/models/userModel.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _projectCollectionReference =
      FirebaseFirestore.instance.collection('projects');
  final StreamController<List<ProjectModel>> _projectController =
      StreamController<List<ProjectModel>>.broadcast();

  Future createUser(UserModel user) async {
    try {
      await _usersCollectionReference.doc(user.studentId).set(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
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
        return e.message;
      }
      return e.message;
    }
  }

  Future updateUser(UserModel user) async {
    try {
      return await _usersCollectionReference
          .doc(user.studentId)
          .update(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.message;
    }
  }

  Future createProject(ProjectModel project) async {
    try {
      await _projectCollectionReference.add(project.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.message;
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
        return e.message;
      }
      return e.message;
    }
  }

  Future updateProject(ProjectModel project) async {
    try {
      await _projectCollectionReference
          .doc(project.projectId)
          .update(project.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.message;
    }
  }

  Future deleteProject(ProjectModel project) async {
    try {
      return await _projectCollectionReference.doc(project.projectId).delete();
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.message;
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
