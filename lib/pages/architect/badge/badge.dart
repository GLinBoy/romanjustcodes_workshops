import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/architect/splash/splash.dart';

class DonutShoppingCartBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Utils.mainColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          Text(
            '2',
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
    );
  }
}
