import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:romanjustcodes_workshops/pages/fullstack/bank_splash/bank_splash.dart';

class FlutterBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FlutterBankSplash(),
    );
  }
}
