import 'dart:async';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romanjustcodes_workshops/pages/fullstack/bank_login/login_service.dart';
import 'package:romanjustcodes_workshops/pages/fullstack/utils/utils.dart';

class FlutterBankMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Utils.mainThemeColor),
        backgroundColor: Colors.transparent,
        title: const Icon(
          Icons.savings,
          color: Utils.mainThemeColor,
          size: 40,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(
                  Icons.account_balance_wallet,
                  color: Utils.mainThemeColor,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'My Accounts',
                  style: TextStyle(
                    color: Utils.mainThemeColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<FlutterBankService>(
                builder: (context, bankService, child) {
                  return FutureBuilder(
                    future: bankService.getAccounts(context),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState != ConnectionState.done ||
                          !snapshot.hasData) {
                        return FlutterBankLoading();
                      }

                      List<Account> accounts = snapshot.data as List<Account>;
                      if (accounts.isEmpty) {
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.account_balance_wallet,
                                color: Utils.mainThemeColor,
                                size: 50,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'You don\'t have any accounts\nassociated with your profile.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Utils.mainThemeColor,
                                ),
                              )
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: accounts.length,
                        itemBuilder: (context, index) {
                          var acct = accounts[index];
                          return AccountCard(account: acct);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
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
        .doc('lLBuBs7RUKfNnhSs0UjHeIgoojr2')
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

class AccountCard extends StatelessWidget {
  final Account? account;

  const AccountCard({Key? key, this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                '${account!.type!.toUpperCase()} ACCT',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Utils.mainThemeColor,
                  fontSize: 12,
                ),
              ),
              Text('**** ${account!.accountNumber}'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Balance',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Utils.mainThemeColor,
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.monetization_on,
                    color: Utils.mainThemeColor,
                    size: 35,
                  ),
                  Text(
                    '\$${account!.balance!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
              Text(
                'As of ${DateFormat.yMd().add_jm().format(DateTime.now())}',
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FlutterBankLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          children: const [
            Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Utils.mainThemeColor),
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.savings,
                color: Utils.mainThemeColor,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
