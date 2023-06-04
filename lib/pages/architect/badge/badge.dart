import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romanjustcodes_workshops/pages/architect/cart/cart_service.dart';
import 'package:romanjustcodes_workshops/pages/architect/splash/splash.dart';

class DonutShoppingCartBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DonutShoppingCartService>(
      builder: (context, cartService, child) {
        if (cartService.cartDonuts.isEmpty) {
          return SizedBox();
        }
        return Transform.scale(
          scale: 0.7,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: Utils.mainColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: [
                Text(
                  '${cartService.cartDonuts.length}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.shopping_cart,
                  size: 25,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
