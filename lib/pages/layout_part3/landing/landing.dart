import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('<BG_IMAGE_PATH>'),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
