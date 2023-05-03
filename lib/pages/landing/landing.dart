import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  SplashPage({ super.key })

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      drawer: Drawer(),
      body: Center(
        child: Text('Welcome to Mounts of the World!'),
      ),
    );
  }
}
