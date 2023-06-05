import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romanjustcodes_workshops/pages/architect/cart/cart_service.dart';
import 'package:romanjustcodes_workshops/pages/architect/cart/shopping_list.dart';
import 'package:romanjustcodes_workshops/pages/architect/splash/splash.dart';

class DonutShoppingCartPage extends StatefulWidget {
  @override
  State<DonutShoppingCartPage> createState() => _DonutShoppingCartPageState();
}

class _DonutShoppingCartPageState extends State<DonutShoppingCartPage>
    with SingleTickerProviderStateMixin {
  AnimationController? titleAnimation;

  @override
  void initState() {
    super.initState();
    titleAnimation = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..forward();
  }

  @override
  void dispose() {
    titleAnimation!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: titleAnimation!,
                curve: Curves.easeInOut,
              ),
            ),
            child: Image.network(Utils.donutTitleMyDonuts, width: 170),
          ),
          Expanded(
            child: Consumer<DonutShoppingCartService>(
              builder: (context, cartService, child) {
                if (cartService.cartDonuts.isEmpty) {
                  return Center(
                    child: SizedBox(
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.grey[300],
                            size: 50,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'You don\'t have any item on your cart yet!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return DonutShoppingList(
                  donutCart: cartService.cartDonuts,
                  cartService: cartService,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
