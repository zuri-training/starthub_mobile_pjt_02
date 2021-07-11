import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/providers/projects.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:starthub_mobile_pjt/providers/user.dart';
import 'package:starthub_mobile_pjt/service/authentication.dart';
import 'package:starthub_mobile_pjt/wrapper.dart';

import 'locator.dart';
import 'widget/loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await Firebase.initializeApp();
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

    return MultiProvider(
        providers: [
          StreamProvider<User>.value(
            value: AuthService().user,
            initialData: null,
          ),
          ChangeNotifierProvider(create: (_) => Users()),
          ChangeNotifierProvider(create: (_) => Projects()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'StartHub',
          theme: ThemeData(
            appBarTheme: AppBarTheme(color: Colors.white),
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Wrapper(),
        ));
  }
}
