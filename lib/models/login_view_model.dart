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

    var result = await _authService.loginWithEmail(email, password);
    setBusy(true);

    if (result != null) {
      if (result) {
        print('homme is here');
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
            title: "Login Failure",
            description: 'General login failure. Please try again later');
      }
    } else {
      await _dialogService.showDialog(
          title: "Login Failure", description: result);
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}
