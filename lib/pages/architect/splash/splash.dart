import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController? donutController;
  Animation<double>? rotationAnimation;

  @override
  void initState() {
    super.initState();
    donutController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: donutController!,
        curve: Curves.linear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DonutShopMain()),
      );
    });
    return Scaffold(
      backgroundColor: Utils.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotationTransition(
              turns: rotationAnimation!,
              child: Image.network(
                Utils.donutLogoWhiteNoText,
                width: 100,
                height: 100,
              ),
            ),
            Image.network(
              Utils.donutLogoWhiteText,
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    donutController!.dispose();
    super.dispose();
  }
}

class DonutShopMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DonutSideMenu(),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Utils.mainDark),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.network(
          Utils.donutLogoRedText,
          width: 120,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          DonutBottomBar(),
        ],
      ),
    );
  }
}

class DonutSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Utils.mainDark,
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Image.network(
              Utils.donutLogoWhiteNoText,
              width: 100,
            ),
          ),
          Image.network(
            Utils.donutLogoWhiteText,
            width: 150,
          ),
        ],
      ),
    );
  }
}

class DonutBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Consumer<DonutBottomBarSelectionService>(
          builder: (context, bottomBarSelectionService, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.trip_origin,
                color: bottomBarSelectionService.tabSelection == 'main'
                    ? Utils.mainDark
                    : Utils.mainColor,
              ),
              onPressed: () {
                bottomBarSelectionService.setTabSelection('main');
              },
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: bottomBarSelectionService.tabSelection == 'favorite'
                    ? Utils.mainDark
                    : Utils.mainColor,
              ),
              onPressed: () {
                bottomBarSelectionService.setTabSelection('favorite');
              },
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: bottomBarSelectionService.tabSelection == 'shoppingcart'
                    ? Utils.mainDark
                    : Utils.mainColor,
              ),
              onPressed: () {
                bottomBarSelectionService.setTabSelection('shoppingcart');
              },
            ),
          ],
        );
      }),
    );
  }
}

class DonutBottomBarSelectionService extends ChangeNotifier {
  String? tabSelection = 'main';

  void setTabSelection(String selection) {
    tabSelection = selection;
    notifyListeners();
  }
}

class Utils {
  static const Color mainColor = Color(0xFFFF0F7E);
  static const Color mainDark = Color(0xFF980346);
  static const String donutLogoWhiteNoText =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_logowhite_notext.png';
  static const String donutLogoWhiteText =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_text_reversed.png';
  static const String donutLogoRedText =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_text.png';
  static const String donutTitleFavorites =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_favorites_title.png';
  static const String donutTitleMyDonuts =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_mydonuts_title.png';
  static const String donutPromo1 =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_promo1.png';
  static const String donutPromo2 =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_promo2.png';
  static const String donutPromo3 =
      'https://romanejaquez.github.io/flutter-codelab4/assets/donut_promo3.png';
}
