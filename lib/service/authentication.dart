import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:starthub_mobile_pjt/models/userModel.dart';
import 'package:starthub_mobile_pjt/service/firestore_service.dart';

class AuthService with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreService _firestoreService = locator<FirestoreService>();
  UserModel _currentUser;
  UserModel get currentUser => _currentUser;

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  // signIn with email/password
  Future signIn(
      {@required String email,
      @required String password,
      @required String firstname,
      @required String lastname}) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Create a new user on firestore
      await _firestoreService.createUser(UserModel(
          studentId: authResult.user.uid,
          emailAdd: email,
          fName: firstname,
          lName: lastname));
      User user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage('No Internet Connection');
    } catch (e) {
      setLoading(false);
      setMessage(e.message);
    }
    notifyListeners();
  }

  // create method to sign in with email/password
  Future login(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage('No Internet Connection');
    } catch (e) {
      setLoading(false);
      setMessage(e.message);
    }
    notifyListeners();
  }

  // sign out
  Future logout() async {
    await _auth.signOut();
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _auth.currentUser;
    await _populateCurrentUser(user);
    return user != null;
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  // auth change user stream

  Stream<User> get user {
    return _auth.authStateChanges().map((event) => event);
  }

  Future _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }
}
