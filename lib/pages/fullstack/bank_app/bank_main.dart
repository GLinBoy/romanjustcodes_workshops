import 'dart:async';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romanjustcodes_workshops/pages/fullstack/bank_login/login_service.dart';
import 'package:romanjustcodes_workshops/pages/fullstack/bank_login/main_button.dart';
import 'package:romanjustcodes_workshops/pages/fullstack/utils/utils.dart';

class FlutterBankMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(child: FlutterBankDrawer()),
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
      bottomNavigationBar: FlutterBankBottomBar(),
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
  Account? selectedAccount;

  void setSelectedAccount(Account? acct) {
    selectedAccount = acct;
    notifyListeners();
  }

  Account? getSelectedAccount() {
    return selectedAccount;
  }

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
        .then(
      (QuerySnapshot collection) {
        for (var doc in collection.docs) {
          var acctDoc = doc.data() as Map<String, dynamic>;
          var acct = Account.fromJson(acctDoc, doc.id);
          accounts.add(acct);
        }

        Future.delayed(const Duration(seconds: 1), () {
          accountsCompleter.complete(accounts);
        });
      },
      onError: (error) {
        accountsCompleter.completeError({'error': error});
      },
    );

    return accountsCompleter.future;
  }

  Future<bool> performDeposit(BuildContext context) {
    Completer<bool> depositComplete = Completer();

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId();

    DepositService depositService =
        Provider.of<DepositService>(context, listen: false);
    int amountToDeposit = depositService.amountToDeposit.toInt();

    DocumentReference doc = FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId)
        .collection('user_account')
        .doc(selectedAccount!.id!);

    doc.update({'balance': selectedAccount!.balance! + amountToDeposit}).then(
        (value) {
      depositService.resetDepositService();
      depositComplete.complete(true);
    }, onError: (error) {
      depositComplete.completeError({'error': error});
    });

    return depositComplete.future;
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

class FlutterBankBottomBarItem {
  String? label;
  IconData? icon;
  Function? action;

  FlutterBankBottomBarItem({this.label, this.icon, this.action});
}

class FlutterBankBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bottomItems = Utils.getBottomBarItems(context);

    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Utils.mainThemeColor.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          bottomItems.length,
          (index) {
            FlutterBankBottomBarItem bottomItem = bottomItems[index];

            return Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                highlightColor: Utils.mainThemeColor.withOpacity(0.2),
                splashColor: Utils.mainThemeColor.withOpacity(0.1),
                onTap: () {
                  bottomItem.action!();
                },
                child: Container(
                  constraints: BoxConstraints(minWidth: 80),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        bottomItem.icon,
                        color: Utils.mainThemeColor,
                        size: 20,
                      ),
                      Text(
                        bottomItem.label!,
                        style: TextStyle(
                          color: Utils.mainThemeColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FlutterBankDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Utils.mainThemeColor,
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.savings,
            color: Colors.white,
            size: 60,
          ),
          const SizedBox(height: 40),
          Material(
            color: Colors.transparent,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.white.withOpacity(0.1),
                ),
              ),
              child: const Text(
                'Sign Out',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Utils.signOutDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DepositService extends ChangeNotifier {
  double amountToDeposit = 0;

  void setAmountToDeposit(double amount) {
    amountToDeposit = amount;
    notifyListeners();
  }

  void resetDepositService() {
    amountToDeposit = 0;
    notifyListeners();
  }

  bool checkAmountToDeposit() {
    return amountToDeposit > 0;
  }
}

class FlutterBankDeposit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Utils.mainThemeColor),
        backgroundColor: Colors.transparent,
        title: const Icon(Icons.savings, color: Utils.mainThemeColor, size: 40),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AccountActionHeader(headerTitle: 'Deposit', icon: Icons.login),
            Expanded(
              child: AccountActionSelection(
                actionTypeLabel: 'To',
                amountChanger: AccountDepositSlider(),
              ),
            ),
            Consumer<DepositService>(
              builder: (context, depositService, child) {
                return FlutterBankMainButton(
                  enabled: depositService.checkAmountToDeposit(),
                  label: 'Make Deposit',
                  onTap: depositService.checkAmountToDeposit()
                      ? () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TransactionCompletionPage(
                                isDeposit: true,
                              ),
                            ),
                          );
                        }
                      : null,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class AccountActionHeader extends StatelessWidget {
  final String? headerTitle;
  final IconData? icon;

  const AccountActionHeader({this.headerTitle, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: Utils.mainThemeColor, size: 30),
          const SizedBox(width: 10),
          Text(
            headerTitle!,
            style: const TextStyle(color: Utils.mainThemeColor, fontSize: 20),
          )
        ],
      ),
    );
  }
}

class AccountActionSelection extends StatelessWidget {
  final String? actionTypeLabel;
  final Widget? amountChanger;

  const AccountActionSelection({
    this.actionTypeLabel,
    required this.amountChanger,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FlutterBankService>(
      builder: ((context, service, child) {
        return FutureBuilder(
          future: service.getAccounts(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return FlutterBankLoading();
            }
            if (snapshot.hasError) {
              return FlutterBankError();
            }

            var selectedAccount = service.getSelectedAccount();
            List<Account> accounts = snapshot.data as List<Account>;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  actionTypeLabel!,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(height: 10),
                AccountActionCard(
                  selectedAccount: selectedAccount,
                  accounts: accounts,
                ),
                Expanded(
                  child: Visibility(
                    visible: selectedAccount != null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Text(
                            'Current Balance',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.monetization_on,
                              color: Utils.mainThemeColor,
                              size: 15,
                            ),
                            Text(
                              selectedAccount != null
                                  ? '\$' +
                                      selectedAccount.balance!
                                          .toStringAsFixed(2)
                                  : '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                              ),
                            )
                          ],
                        ),
                        Expanded(child: amountChanger!),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}

class FlutterBankError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.warning_outlined, color: Utils.mainThemeColor, size: 20),
          SizedBox(height: 20),
          Text(
            'Error fetching data',
            style: TextStyle(
              color: Utils.mainThemeColor,
              fontSize: 20,
            ),
          ),
          Text(
            'Please try again',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class AccountActionCard extends StatelessWidget {
  final List<Account>? accounts;
  final Account? selectedAccount;

  const AccountActionCard({super.key, this.accounts, this.selectedAccount});

  @override
  Widget build(BuildContext context) {
    FlutterBankService bankService =
        Provider.of<FlutterBankService>(context, listen: false);

    return Row(
      children: List.generate(
        accounts!.length,
        (index) {
          var currentAccount = accounts![index];
          return Expanded(
            child: GestureDetector(
              onTap: () {
                bankService.setSelectedAccount(currentAccount);
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0.0, 5.0),
                    ),
                  ],
                  border: Border.all(
                    width: 5,
                    color: selectedAccount != null &&
                            selectedAccount!.id == currentAccount.id
                        ? Utils.mainThemeColor
                        : Colors.transparent,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${currentAccount.type!.toUpperCase()} ACCT',
                      style: TextStyle(color: Utils.mainThemeColor),
                    ),
                    Text(currentAccount.accountNumber!),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AccountDepositSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DepositService>(builder: (context, DepositService, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Amount To Deposit',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            '\$${DepositService.amountToDeposit.toInt().toString()}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 60,
            ),
          ),
          Slider(
            value: DepositService.amountToDeposit,
            max: 1000,
            activeColor: Utils.mainThemeColor,
            inactiveColor: Colors.grey.withOpacity(0.5),
            thumbColor: Utils.mainThemeColor,
            onChanged: (double value) {
              DepositService.setAmountToDeposit(value);
            },
          ),
        ],
      );
    });
  }
}

class TransactionCompletionPage extends StatelessWidget {
  final bool? isDeposit;

  const TransactionCompletionPage({Key? key, this.isDeposit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterBankService bankService =
        Provider.of<FlutterBankService>(context, listen: false);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });

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
      body: Center(
        child: FutureBuilder(
          future: bankService.performDeposit(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return FlutterBankLoading();
            }

            if (snapshot.hasError) {
              return FlutterBankError();
            }

            return FlutterBankTransactionComplete();
          },
        ),
      ),
    );
  }
}

class FlutterBankTransactionComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          Icons.check_circle_outline_outlined,
          color: Utils.mainThemeColor,
          size: 80,
        ),
        SizedBox(height: 20),
        Text(
          'Transaction Complete',
          style: TextStyle(color: Utils.mainThemeColor, fontSize: 20),
        ),
      ],
    );
  }
}
