import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/architect/splash/splash.dart';

class DonutShopDetails extends StatefulWidget {
  @override
  State<DonutShopDetails> createState() => _DonutShopDetailsState();
}

class _DonutShopDetailsState extends State<DonutShopDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Utils.mainDark),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(
          width: 120,
          child: Image.network(Utils.donutLogoRedText),
        ),
      ),
    );
  }
}
