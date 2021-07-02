import 'package:flutter/widgets.dart';
import 'package:starthub_mobile_pjt/locator.dart';
import 'package:starthub_mobile_pjt/models/userModel.dart';
import 'package:starthub_mobile_pjt/service/authentication.dart';

class BaseModel extends ChangeNotifier {
  final AuthService _authService = locator<AuthService>();

  UserModel get currentUser => _authService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}