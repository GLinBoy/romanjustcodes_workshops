import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/layout_part3/landing/landing.dart';

const mainThemeColor = Color(0xFF272D8D);

final List<Attraction> attractionsList = [
  Attraction(
      imgPath: 'images/layout_part3/275162028.jpg',
      name: 'Grand Bavaro Princess',
      desc: 'All-Inclusive Resort',
      location: 'Punta Cana, DR',
      rating: 3,
      price: 80.0),
  Attraction(
      imgPath: 'images/layout_part3/232161008.jpg',
      name: 'Hyatt Ziva Cap Cana',
      desc: 'All-Inclusive Resort',
      price: 90.0,
      rating: 4,
      location: 'Punta Cana, DR'),
  Attraction(
      imgPath: 'images/layout_part3/256931299.jpg',
      name: 'Impressive Punta Cana',
      desc: 'All-Inclusive Resort',
      price: 100.0,
      rating: 5,
      location: 'Punta Cana, DR'),
  Attraction(
      imgPath: 'images/layout_part3/283750757.jpg',
      name: 'Villas Mar Azul Dreams',
      desc: 'All-Inclusive Resort',
      price: 100.0,
      rating: 4,
      location: 'Tallaboa, PR'),
];

final List<BottomBarItem> barItemsList = [
  BottomBarItem(label: 'Home', isSelected: true, icon: Icons.home),
  BottomBarItem(label: 'Account', isSelected: false, icon: Icons.person),
  BottomBarItem(
      label: 'Bookings', isSelected: false, icon: Icons.pending_actions),
  BottomBarItem(label: 'Payments', isSelected: false, icon: Icons.payments),
  BottomBarItem(label: 'More', isSelected: false, icon: Icons.more_horiz),
];

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LandingPage(),
          ),
        );
      },
    );

    return Stack(
      children: [
        Container(
          color: mainThemeColor,
        ),
        const Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.pool,
            color: Colors.white,
            size: 80,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white.withOpacity(0.4)),
          ),
        ),
      ],
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: const Icon(
          Icons.pool,
          color: Colors.white,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: mainThemeColor,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: attractionsList.length,
                  itemBuilder: (context, index) {
                    Attraction attr = attractionsList[index];
                    return AttractionCard(attraction: attr);
                  },
                ),
              ),
              const BottomBarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class AttractionCard extends StatelessWidget {
  Attraction? attraction;

  AttractionCard({this.attraction, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: Offset.zero,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          height: 300,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(attraction!.imgPath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              attraction!.name!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.pin_drop,
                                  color: Colors.grey.withOpacity(0.7),
                                  size: 12,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  attraction!.location!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 5),
                            RatingWidget(rating: attraction!.rating!),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '\$${attraction!.price!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Per Night',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: mainThemeColor,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: mainThemeColor.withOpacity(0.5),
                        offset: Offset.zero,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  int? rating;

  RatingWidget({this.rating, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < this.rating! ? Icons.star : Icons.star_border,
              color: Colors.yellow,
            );
          }),
        ),
        const SizedBox(width: 5),
        Text(
          '${this.rating!}/5 Reviews',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  BottomBarWidgetState createState() => BottomBarWidgetState();
}

class BottomBarWidgetState extends State<BottomBarWidget> {
  List<BottomBarItem> barItems = barItemsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          barItems.length,
          (index) {
            var barItem = barItems[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  barItems.forEach((element) {
                    element.isSelected = barItem == element;
                  });
                });
              },
              child: Column(
                children: [
                  Icon(
                    barItem.icon,
                    color: barItem.isSelected! ? mainThemeColor : Colors.grey,
                  ),
                  Text(
                    barItem.label!,
                    style: TextStyle(
                      color:
                          (barItem.isSelected! ? mainThemeColor : Colors.grey),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Attraction {
  String? imgPath;
  String? name;
  String? desc;
  double? price;
  String? location;
  int? rating;

  Attraction(
      {this.imgPath,
      this.name,
      this.desc,
      this.price,
      this.location,
      this.rating});
}

class BottomBarItem {
  String? label;
  bool? isSelected;
  IconData? icon;

  BottomBarItem({this.label, this.isSelected, this.icon});
}
