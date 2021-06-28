import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/authentication/login_screen.dart';
import 'package:starthub_mobile_pjt/authentication/sign_up.dart';
import 'package:starthub_mobile_pjt/screen/project_screen.dart';
import 'package:starthub_mobile_pjt/widget/route_name.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(routeName: settings.name, viewToShow: LogIn());
    
    case SignUpViewRoute:
      return _getPageRoute(routeName: settings.name, viewToShow: SignUp());
    
    case HomeViewRoute:
      return _getPageRoute(routeName: settings.name, viewToShow: ProjectScreen());
    
    // case CreateProjectViewRoute:
    //   return _getPageRoute(routeName: settings.name, viewToShow: CreateProjectView());

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      builder: (_) => viewToShow, settings: RouteSettings(name: routeName));
}
