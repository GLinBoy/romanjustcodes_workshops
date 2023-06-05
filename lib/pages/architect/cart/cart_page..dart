import 'package:flutter/material.dart';
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
        ],
      ),
    );
  }
}
