import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:starthub_mobile_pjt/locator.dart';
import 'package:starthub_mobile_pjt/models/userModel.dart';
import 'package:starthub_mobile_pjt/service/firestore_service.dart';

class AuthService with ChangeNotifier {
  String _errorMessage;
  String get errorMessage => _errorMessage;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreService _firestoreService = locator<FirestoreService>();
  UserModel _currentUser;
  UserModel get currentUser => _currentUser;

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  // signIn with email/password
  Future signUp(
      {@required String email,
      @required String password,
      @required String firstname,
      @required String lastname}) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password).then((value) =>  _firestoreService.createUser(UserModel(
          studentId: value.user.uid,
          emailAdd: email,
          fName: firstname,
          lName: lastname)
          )
          );
      return authResult.user != null;
    } on SocketException {
      setMessage('No Internet Connection');
    } catch (e) {
      setMessage(e.toString());
    }
    notifyListeners();
  }

  // create method to sign in with email/password
  Future loginWithEmail(String email, String password) async {
    try {
     var authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await _populateCurrentUser(authResult.user);
      
      return authResult.user != null;
    } on SocketException {
      setMessage('No Internet Connection');
    } catch (e) {
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
