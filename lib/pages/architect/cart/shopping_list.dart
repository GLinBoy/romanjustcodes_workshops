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
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<DonutModel> insertedItems = [];

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _key,
      initialItemCount: insertedItems.length,
      itemBuilder: (context, index, animation) {
        DonutModel currentDonut = widget.donutCart![index];
        return SlideTransition(
          position: Tween(
            begin: const Offset(0.0, 0.2),
            end: const Offset(0.0, 0.0),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: DonutShoppingListRow(
              donut: currentDonut,
              onDeleteRow: () {
                widget.cartService!.removeFromCart(currentDonut);
              },
            ),
          ),
        );
      },
    );
  }
}
