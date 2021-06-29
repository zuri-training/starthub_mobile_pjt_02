import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Network not available, Reconnecting'), CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.white),strokeWidth: 2,)],
        ),
      
    );
  }
}