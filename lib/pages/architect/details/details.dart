import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/architect/main/main.dart';
import 'package:romanjustcodes_workshops/pages/architect/splash/splash.dart';

class DonutShopDetails extends StatefulWidget {
  @override
  State<DonutShopDetails> createState() => _DonutShopDetailsState();
}

class _DonutShopDetailsState extends State<DonutShopDetails> {
  DonutModel? selectedDonut;

  @override
  Widget build(BuildContext context) {
    selectedDonut = Utils.donuts[0];

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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Positioned(
                  top: -40,
                  right: -120,
                  child: Image.network(
                    selectedDonut!.imgUrl!,
                    width: MediaQuery.of(context).size.width * 1.25,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(),
          ),
        ],
      ),
    );
  }
}
