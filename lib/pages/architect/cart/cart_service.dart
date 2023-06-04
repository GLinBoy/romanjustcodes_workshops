import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/architect/main/main.dart';

class DonutShoppingCartService extends ChangeNotifier {
  List<DonutModel> cartDonuts = [];

  void addToCart(DonutModel donut) {
    cartDonuts.add(donut);
    notifyListeners();
  }

  void removeFromCart(DonutModel donut) {
    cartDonuts.remove((d) => d.name == donut.name);
    notifyListeners();
  }
}
