import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/providers/projects.dart';
import 'package:flutter/services.dart';
import 'package:starthub_mobile_pjt/screen/profile.dart';

import 'package:provider/provider.dart';
import 'package:starthub_mobile_pjt/providers/user.dart';
import 'package:starthub_mobile_pjt/screen/project-detail.dart';
// import 'package:starthub_mobile_pjt/authentication/signup_screen.dart';
// import 'package:starthub_mobile_pjt/screen/signup_screen.dart';
import 'package:starthub_mobile_pjt/screen/project_screen.dart';
import 'package:starthub_mobile_pjt/screen/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Projects()),
        ChangeNotifierProvider(create: (_) => User()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'StartHub',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white
          ),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash(),
        routes: {
          ProjectDetailScreen.routeName: (context) => ProjectDetailScreen(),
        },
      ),
    );
  }
}
