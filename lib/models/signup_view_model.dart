import 'package:flutter/foundation.dart';
import 'package:starthub_mobile_pjt/models/base_model.dart';
import 'package:starthub_mobile_pjt/models/login_view_model.dart';
import 'package:starthub_mobile_pjt/service/authentication.dart';
import 'package:starthub_mobile_pjt/service/dialog_service.dart';
import 'package:starthub_mobile_pjt/service/navigation_service.dart';
import 'package:starthub_mobile_pjt/widget/route_name.dart';

class SignUpViewModel extends BaseModel {
  final AuthService _authService = AuthService();
  final DialogService _dialogService = DialogService();
  final NavigationService _navigationService = NavigationService();

  Future signup({
    @required String email,
    @required String password,
    @required String firstname,
    @required String lastname,
  }) async {
    setBusy(true);

    var result = await _authService.signIn(email: email, password: password, firstname: firstname, lastname: lastname);
    setBusy(true);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
            title: "Login Failure",
            description: 'General login failure. Please try again later');
      }
    } else {
      await _dialogService.showDialog(
          title: "Sign Up Failure", description: result);
    }
  }

  void navigateToLogin() {
    _navigationService.navigateTo(LoginViewRoute);
  }
}
