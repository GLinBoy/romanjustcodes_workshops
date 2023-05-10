import 'package:flutter/material.dart';

const mainThemeColor = Color(0xFF272D8D);

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: mainThemeColor,
        ),
        Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.pool,
            color: Colors.white,
            size: 80,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white.withOpacity(0.4)),
          ),
        ),
      ],
    );
  }
}
