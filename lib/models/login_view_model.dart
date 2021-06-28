import 'package:flutter/foundation.dart';
import 'package:starthub_mobile_pjt/models/base_model.dart';
import 'package:starthub_mobile_pjt/service/authentication.dart';
import 'package:starthub_mobile_pjt/service/dialog_service.dart';
import 'package:starthub_mobile_pjt/service/navigation_service.dart';
import 'package:starthub_mobile_pjt/widget/route_name.dart';

class LoginViewModel extends BaseModel {
  final AuthService _authService = AuthService();
  final DialogService _dialogService = DialogService();
  final NavigationService _navigationService = NavigationService();

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authService.loginWithEmail(email, password);
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
          title: "Login Failure", description: result);
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}
