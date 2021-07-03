import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starthub_mobile_pjt/screen/homepage.dart';
import 'package:starthub_mobile_pjt/screen/onboarding.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // this will return home or auth screen
    final user = Provider.of<User>(context);
    if (user != null) {
      return Homepage();
    } else {
      return Onboarding();
    }
  }
}
