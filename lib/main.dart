import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/models/startup_view_model.dart';
import 'package:starthub_mobile_pjt/providers/projects.dart';
import 'package:flutter/services.dart';
import 'package:starthub_mobile_pjt/router.dart';
import 'package:provider/provider.dart';
import 'package:starthub_mobile_pjt/providers/user.dart';
import 'package:starthub_mobile_pjt/screen/project-detail.dart';
import 'package:starthub_mobile_pjt/screen/project_screen.dart';
import 'package:starthub_mobile_pjt/screen/splashscreen.dart';
import 'package:starthub_mobile_pjt/service/authentication.dart';
import 'package:starthub_mobile_pjt/service/navigation_service.dart';

import 'locator.dart';
import 'service/dialog_manager.dart';
import 'service/dialog_service.dart';
import 'widget/loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.grey,
        systemNavigationBarColor: Colors.grey,
        systemNavigationBarIconBrightness: Brightness.dark));
    final _init = Firebase.initializeApp();
    return FutureBuilder<FirebaseApp>(
        future: _init,
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider<AuthService>.value(
                    value: AuthService(),
                  ),
                  ChangeNotifierProvider(create: (_) => User()),
                  ChangeNotifierProvider(create: (_) => Projects()),
                ],
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  builder: (context, child) => Navigator(
                    key: locator<DialogService>().dialogNavigationKey,
                    onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => DialogManager(child: child)),
                  ),
                  navigatorKey: locator<NavigationService>().navigationkey,
                  title: 'StartHub',
                  theme: ThemeData(
                    appBarTheme: AppBarTheme(color: Colors.white),
                    primarySwatch: Colors.blue,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  home: Splash(),
                  // routes: {
                  //   ProjectDetailScreen.routeName: (context) => ProjectScreen(),
                  // },
                  onGenerateRoute: generateRoute,
                ));
          } else {
            return MaterialApp(home: LoadingWidget());
          }
        });
  }
}
