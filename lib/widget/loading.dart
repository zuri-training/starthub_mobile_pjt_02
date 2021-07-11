import 'package:flutter/material.dart';
import 'package:starthub_mobile_pjt/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackground,
      child: Center(
        child: SpinKitChasingDots(color: kPrimaryColor, size: 50.0),
      ),
    );
  }
}
