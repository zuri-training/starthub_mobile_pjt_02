import 'package:starthub_mobile_pjt/models/base_model.dart';
import 'package:starthub_mobile_pjt/screen/onboarding.dart';
import 'package:starthub_mobile_pjt/service/authentication.dart';
import 'package:starthub_mobile_pjt/service/navigation_service.dart';
import 'package:starthub_mobile_pjt/widget/route_name.dart';

import '../locator.dart';

class StartUpViewModel extends BaseModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var userLoggedIn = await _authService.isUserLoggedIn();

    if (userLoggedIn) {
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _navigationService.navigateTo(OnboardingView);
    }
  }
}
