import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romanjustcodes_workshops/pages/architect/cart/cart_page.dart';
import 'package:romanjustcodes_workshops/pages/architect/cart/cart_service.dart';
import 'package:romanjustcodes_workshops/pages/architect/main/main.dart';

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
      Utils.mainAppNav.currentState!.pushReplacementNamed('/main');
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
  const DonutShopMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
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
            child: Navigator(
              key: Utils.mainListNav,
              initialRoute: '/main',
              onGenerateRoute: (RouteSettings settings) {
                Widget page;
                switch (settings.name) {
                  case '/main':
                    page = DonutMainPage();
                    break;
                  case '/favorites':
                    page = const Center(child: Text('favorites'));
                    break;
                  case '/shoppingcart':
                    page = DonutShoppingCartPage();
                    break;
                  default:
                    page = const Center(child: Text('main'));
                    break;
                }
                return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => page,
                  transitionDuration: const Duration(seconds: 0),
                );
              },
            ),
          ),
          DonutBottomBar(),
        ],
      ),
    );
  }
}

class DonutSideMenu extends StatelessWidget {
  const DonutSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Utils.mainDark,
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
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
      padding: const EdgeInsets.all(30),
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
                bottomBarSelectionService.setTabSelection('favorites');
              },
            ),
            Consumer<DonutShoppingCartService>(
              builder: (context, cartService, child) {
                int cartItems = cartService.cartDonuts.length;
                return Container(
                  constraints: BoxConstraints(minHeight: 70),
                  padding: (EdgeInsets.all(10)),
                  decoration: BoxDecoration(
                    color: cartItems > 0
                        ? (bottomBarSelectionService.tabSelection! == 'shopping'
                            ? Utils.mainDark
                            : Utils.mainColor)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      cartItems > 0
                          ? Text(
                              '$cartItems',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )
                          : SizedBox(height: 17),
                      SizedBox(height: 10),
                      Icon(
                        Icons.shopping_cart,
                        color: cartItems > 0
                            ? Colors.white
                            : (bottomBarSelectionService.tabSelection! ==
                                    'shopping'
                                ? Utils.mainDark
                                : Utils.mainColor),
                      ),
                    ],
                  ),
                );
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
    Utils.mainListNav.currentState!.pushReplacementNamed('/' + selection);
    tabSelection = selection;
    notifyListeners();
  }
}

class Utils {
  static GlobalKey<NavigatorState> mainListNav = GlobalKey();
  static GlobalKey<NavigatorState> mainAppNav = GlobalKey();

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

  static List<DonutModel> donuts = [
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic1.png',
        name: 'Strawberry Sprinkled Glazed',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 1.99,
        type: 'classic'),
    DonutModel(
      imgUrl:
          'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic2.png',
      name: 'Chocolate Glazed Doughnut',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
      price: 2.99,
      type: 'classic',
    ),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic3.png',
        name: 'Chocolate Dipped Doughnut',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 2.99,
        type: 'classic'),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic4.png',
        name: 'Cinamon Glazed Glazed',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 2.99,
        type: 'classic'),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic5.png',
        name: 'Sugar Glazed Doughnut',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 1.99,
        type: 'classic'),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutsprinkled/donut_sprinkled1.png',
        name: 'Halloween Chocolate Glazed',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 2.99,
        type: 'sprinkled'),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutsprinkled/donut_sprinkled2.png',
        name: 'Party Sprinkled Cream',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 1.99,
        type: 'sprinkled'),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutsprinkled/donut_sprinkled3.png',
        name: 'Chocolate Glazed Sprinkled',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 1.99,
        type: 'sprinkled'),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutsprinkled/donut_sprinkled4.png',
        name: 'Strawbery Glazed Sprinkled',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 2.99,
        type: 'sprinkled'),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutsprinkled/donut_sprinkled5.png',
        name: 'Reese\'s Sprinkled',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 3.99,
        type: 'sprinkled'),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutstuffed/donut_stuffed1.png',
        name: 'Brownie Cream Doughnut',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 1.99,
        type: 'stuffed'),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutstuffed/donut_stuffed2.png',
        name: 'Jelly Stuffed Doughnut',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 2.99,
        type: 'stuffed'),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutstuffed/donut_stuffed3.png',
        name: 'Caramel Stuffed Doughnut',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 2.59,
        type: 'stuffed'),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutstuffed/donut_stuffed4.png',
        name: 'Maple Stuffed Doughnut',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 1.99,
        type: 'stuffed'),
    DonutModel(
        imgUrl:
            'https://romanejaquez.github.io/flutter-codelab4/assets/donutstuffed/donut_stuffed5.png',
        name: 'Glazed Jelly Stuffed Doughnut',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien.',
        price: 1.59,
        type: 'stuffed')
  ];
}
