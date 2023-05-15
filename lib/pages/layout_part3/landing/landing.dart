import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/layout_part3/splash/splash.dart';

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
          ),
          Container(
            color: mainThemeColor.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
