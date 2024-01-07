import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romanjustcodes_workshops/pages/fullstack/bank_app/bank_main.dart';
import 'package:romanjustcodes_workshops/pages/fullstack/bank_login/login_service.dart';

class Utils {
  static const Color mainThemeColor = Color(0xFF8700C3);

  static bool validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);

    return (value != null || value!.isNotEmpty || regex.hasMatch(value));
  }

  static Widget generateInputField(
    String hintText,
    IconData iconData,
    TextEditingController controller,
    bool isPasswordField,
    Function onChanged,
  ) {
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50)),
        child: TextField(
          onChanged: (text) {
            onChanged(text);
          },
          obscureText: isPasswordField,
          obscuringCharacter: "*",
          decoration: InputDecoration(
              prefixIcon: Icon(iconData, color: Utils.mainThemeColor),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: hintText),
          controller: controller,
          style: const TextStyle(fontSize: 16),
        ));
  }

  static List<FlutterBankBottomBarItem> getBottomBarItems(
      BuildContext context) {
    return [
      FlutterBankBottomBarItem(
        label: 'Withdraw',
        icon: Icons.logout,
        action: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FlutterBankWithdrawal()),
          );
        },
      ),
      FlutterBankBottomBarItem(
        label: 'Deposit',
        icon: Icons.login,
        action: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FlutterBankDeposit()),
          );
        },
      ),
      FlutterBankBottomBarItem(
        label: 'Expenses',
        icon: Icons.payment,
        action: () {},
      ),
    ];
  }

  static void signOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text(
            'Flutter Saving Bank Logout',
            style: TextStyle(color: Utils.mainThemeColor),
          ),
          content: Container(
            padding: const EdgeInsets.all(20),
            child:
                const Text('Are you sure you want to log out of your account?'),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Utils.mainThemeColor),
              ),
              onPressed: () async {
                Navigator.of(ctx).pop();
                LoginService loginService =
                    Provider.of<LoginService>(ctx, listen: false);
                await loginService.signOut();
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
