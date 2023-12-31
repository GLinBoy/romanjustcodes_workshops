import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romanjustcodes_workshops/pages/fullstack/bank_login/login_service.dart';

class FlutterBankMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('main page'),
      ),
    );
  }
}

class Account {
  String? id;
  String? type;
  String? accountNumber;
  double? balance;

  Account({this.id, this.type, this.accountNumber, this.balance});

  factory Account.fromJson(Map<String, dynamic> json, String docId) {
    return Account(
      id: docId,
      type: json['type'],
      accountNumber: json['account_number'],
      balance: json['balance'],
    );
  }
}

class FlutterBankService extends ChangeNotifier {
  Future<List<Account>> getAccounts(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId();

    List<Account> accounts = [];

    Completer<List<Account>> accountsCompleter = Completer();

    FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId)
        .collection('user_accounts')
        .get()
        .then((QuerySnapshot collection) {
      for (var doc in collection.docs) {
        var acctDoc = doc.data() as Map<String, dynamic>;
        var acct = Account.fromJson(acctDoc, doc.id);
        accounts.add(acct);
      }

      Future.delayed(const Duration(seconds: 1), () {
        accountsCompleter.complete(accounts);
      });
    });

    return accountsCompleter.future;
  }
}
