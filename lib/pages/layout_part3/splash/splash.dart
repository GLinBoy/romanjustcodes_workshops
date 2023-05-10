import 'package:flutter/material.dart';

const mainThemeColor = Color(0xFF272D8D);

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ListPage(),
          ),
        );
      },
    );

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

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello Paradise'),
      ),
    );
  }
}
