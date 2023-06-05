import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/architect/cart/cart_service.dart';
import 'package:romanjustcodes_workshops/pages/architect/cart/shopping_list_row.dart';
import 'package:romanjustcodes_workshops/pages/architect/main/main.dart';

class DonutShoppingList extends StatefulWidget {
  List<DonutModel>? donutCart;
  DonutShoppingCartService? cartService;

  DonutShoppingList({this.donutCart, this.cartService});

  @override
  State<DonutShoppingList> createState() => _DonutShoppingListState();
}

class _DonutShoppingListState extends State<DonutShoppingList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.donutCart!.length,
      itemBuilder: (context, index) {
        DonutModel currentDonut = widget.donutCart![index];
        return DonutShoppingListRow(
          donut: currentDonut,
          onDeleteRow: () {
            widget.cartService!.removeFromCart(currentDonut);
          },
        );
      },
    );
  }
}
