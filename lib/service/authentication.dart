// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:starthub_mobile_pjt/locator.dart';
// import 'package:starthub_mobile_pjt/models/userModel.dart';
// import 'package:starthub_mobile_pjt/service/firestore_service.dart';

// class AuthService with ChangeNotifier {
//   String _errorMessage;
//   String get errorMessage => _errorMessage;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   FirestoreService _firestoreService = FirestoreService();
//   UserModel _currentUser;
//   UserModel get currentUser => _currentUser;

//   void setMessage(message) {
//     _errorMessage = message;
//     notifyListeners();
//   }

//   // signIn with email/password
//   Future signUp(
//       {@required String email,
//       @required String password,
//       @required String firstname,
//       @required String lastname}) async {
//     try {
      
//       print('authentication is here');
//       var authResult = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       await FirestoreService(uid: authResult.user.uid)
//           .createUser(firstname, lastname, ' ', ' ', email, password);
//       print("authResult: ${authResult.user}");
//       return authResult.user != null;
//     } on SocketException {
//       setMessage('No Internet Connection');
//     } catch (e) {
//       setMessage(e.toString());
//     }
//     //notifyListeners();
//   }

//   // create method to sign in with email/password
//   Future loginWithEmail(String email, String password) async {
//     try {
//       var authResult = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       await _populateCurrentUser(authResult.user);
//       return authResult.user != null;
//     } on SocketException {
//       setMessage('No Internet Connection');
//     } catch (e) {
//       setMessage(e.toString());
//     }
//   }

//   // sign out
//   Future logout() async {
//     await _auth.signOut();
//   }

//   Future<bool> isUserLoggedIn() async {
//     var user = await _auth.currentUser;
//     await _populateCurrentUser(user);
//     return user != null;
//   }

//   // auth change user stream

//   // Stream<User> get user {
//   //   return _auth.authStateChanges().map((event) => event);
//   // }

//   Future _populateCurrentUser(User user) async {
//     if (user != null) {
//       _currentUser = await _firestoreService.getUser(user.uid);
//       return _currentUser;
//     }
//   }
// }
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:starthub_mobile_pjt/models/userModel.dart';
import 'package:starthub_mobile_pjt/service/firestore_service.dart';

class AuthService with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreService _firestoreService = FirestoreService();
  UserModel _currentUser;
  UserModel get currentUser => _currentUser;

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  // register with email/password
Future register({String firstname,String lastname,String email, String password}) async {
    
    try {
      setLoading(true);
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          await FirestoreService(uid: authResult.user.uid)
          .createUser(firstname, lastname, ' ', ' ', email, password);
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
      await _populateCurrentUser(authResult.user);
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

  // auth change user stream

  Stream<User> get user {
    return _auth.authStateChanges().map((event) => event);
  }


  Future _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
      return _currentUser;
    }
  }
}
