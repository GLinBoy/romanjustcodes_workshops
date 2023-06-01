import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/architect/main/main.dart';
import 'package:romanjustcodes_workshops/pages/architect/splash/splash.dart';

class DonutShopDetails extends StatefulWidget {
  @override
  State<DonutShopDetails> createState() => _DonutShopDetailsState();
}

class _DonutShopDetailsState extends State<DonutShopDetails>
    with SingleTickerProviderStateMixin {
  DonutModel? selectedDonut;
  AnimationController? controller;
  Animation<double>? rotationAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

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
                  child: RotationTransition(
                    turns: rotationAnimation!,
                    child: Image.network(
                      selectedDonut!.imgUrl!,
                      width: MediaQuery.of(context).size.width * 1.25,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${selectedDonut!.name!}',
                          style: TextStyle(
                            color: Utils.mainDark,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                      IconButton(
                        icon: Icon(Icons.favorite_border_outlined),
                        color: Utils.mainDark,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Utils.mainDark,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '\$${selectedDonut!.price!.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('${selectedDonut!.description!}'),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Utils.mainDark.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart, color: Utils.mainDark),
                        SizedBox(width: 20),
                        Text(
                          'Add To Cart',
                          style: TextStyle(color: Utils.mainDark),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
