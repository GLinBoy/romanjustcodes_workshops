import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              Utils.donutLogoWhiteNoText,
              width: 100,
              height: 100,
            ),
            Image.network(
              Utils.donutLogoWhiteText,
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}

class Utils {
  static const Color mainColor = Color(0xFFFF0F7E);
  static const Color mainDark = Color(0xFF980346);
  static const String donutLogoWhiteNoText =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_logowhite_notext.png';
  static const String donutLogoWhiteText =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_text_reversed.png';
  static const String donutLogoRedText =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_text.png';
  static const String donutTitleFavorites =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_favorites_title.png';
  static const String donutTitleMyDonuts =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_mydonuts_title.png';
  static const String donutPromo1 =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_promo1.png';
  static const String donutPromo2 =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_promo2.png';
  static const String donutPromo3 =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_promo3.png';
}
