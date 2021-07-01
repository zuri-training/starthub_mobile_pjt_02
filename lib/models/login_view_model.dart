import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:starthub_mobile_pjt/locator.dart';
import 'package:starthub_mobile_pjt/models/base_model.dart';
import 'package:starthub_mobile_pjt/service/authentication.dart';
import 'package:starthub_mobile_pjt/service/dialog_service.dart';
import 'package:starthub_mobile_pjt/service/navigation_service.dart';
import 'package:starthub_mobile_pjt/widget/route_name.dart';

class LoginViewModel extends BaseModel {
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    UserCredential result = await _authService.loginWithEmail(email, password);
    setBusy(true);
    print('result: $result');
    if (result is bool) {
      print('homme is here');
      return await _navigationService.navigateTo(HomeViewRoute);
    } else {
      return await _dialogService.showDialog(
          title: "Login Failure",
          description: 'General login failure. Please try again later');
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}
