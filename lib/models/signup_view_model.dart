import 'package:flutter/foundation.dart';
import 'package:starthub_mobile_pjt/locator.dart';
import 'package:starthub_mobile_pjt/models/base_model.dart';
import 'package:starthub_mobile_pjt/models/login_view_model.dart';
import 'package:starthub_mobile_pjt/service/authentication.dart';
import 'package:starthub_mobile_pjt/service/dialog_service.dart';
import 'package:starthub_mobile_pjt/service/navigation_service.dart';
import 'package:starthub_mobile_pjt/widget/route_name.dart';

class SignUpViewModel extends BaseModel {
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  signup({
    @required String email,
    @required String password,
    @required String firstname,
    @required String lastname,
    }) {
    setBusy(true);

    var result =_authService.signUp(
        email: email,
        password: password,
        firstname: firstname,
        lastname: lastname);
    setBusy(true);
    print('here');
    print("result: $result");

    if (result is bool) {
      
      if (result != null) {
        return _navigationService.navigateTo(HomeViewRoute);
      } else {
        return _dialogService.showDialog(
            title: "Login Failure",
            description: 'General login failure. Please try again later');
      }
    } else {
      return _dialogService.showDialog(
          title: "Sign Up Failure", description: result.toString());
    }
  }

  void navigateToLogin() {
    _navigationService.navigateTo(LoginViewRoute);
  }
}
