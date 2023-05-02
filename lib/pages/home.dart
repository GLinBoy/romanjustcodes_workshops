import 'package:flutter/material.dart';
import 'splash/splash.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open Route'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SplashPage()));
          },
        ),
      ),
    );
  }
}
