import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'onboarding.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this, value: 0.1);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();

    Timer(
      const Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, __) {
              return ScaleTransition(
                scale: _animation,
                child: const Onboarding(),
              );
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ScaleTransition(
        scale: _animation,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage('assets/images/logo.png'),
              height: screenAwareSize(80, context),
              width: screenAwareSize(66.68, context),
            ),
          ],
        ),
      ),
    );
  }

  screenAwareSize(dynamic i, BuildContext context) {}
}
