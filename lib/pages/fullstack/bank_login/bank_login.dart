import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/fullstack/utils/utils.dart';

class FlutterBankLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FlutterBankLoginState();
}

class FlutterBankLoginState extends State<FlutterBankLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 7,
                  color: Utils.mainThemeColor,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.savings,
                color: Utils.mainThemeColor,
                size: 45,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Welcome to',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            const Text(
              'Flutter\nSavings Bank',
              style: TextStyle(
                color: Utils.mainThemeColor,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
