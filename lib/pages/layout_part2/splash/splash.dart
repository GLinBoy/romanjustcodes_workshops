import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/layout_part2/landing/landing.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LandingPage(),
        ),
      );
    });
    return Stack(
      children: [
        Container(
          color: mainYellow,
        ),
        Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.airplanemode_on,
            color: Colors.black,
            size: 80,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 160,
            height: 160,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.black.withOpacity(0.2),
              ),
              strokeWidth: 10,
            ),
          ),
        ),
      ],
    );
  }
}
