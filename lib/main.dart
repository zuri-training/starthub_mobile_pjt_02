import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
<<<<<<< Updated upstream
import 'package:starthub_mobile_pjt/views/splashscreen.dart';


=======
import 'package:provider/provider.dart';
import 'package:starthub_mobile_pjt/providers/user.dart';
//import 'package:starthub_mobile_pjt/screen/splashscreen.dart';
import 'package:starthub_mobile_pjt/screen/project-detail.dart';
// import 'package:starthub_mobile_pjt/authentication/sign_up.dart';
// import 'package:starthub_mobile_pjt/screen/signup_screen.dart';
import 'package:starthub_mobile_pjt/screen/project_screen.dart';
>>>>>>> Stashed changes

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StartHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}