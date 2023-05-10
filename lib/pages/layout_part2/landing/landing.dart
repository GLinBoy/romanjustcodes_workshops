import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/layout_part2/details/details.dart';

Color mainYellow = const Color(0xFFFFB02F);
Color primaryGray = const Color(0xFF313131);
Color secondaryGray = const Color(0xFF1C1C1C);
Color lightGray = const Color(0xFF3B3B3B);

final List<AttractionModel> attractions = [
  AttractionModel(
      imgPath:
          'https://images.pexels.com/photos/260590/pexels-photo-260590.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
      name: 'Golden Gate Bridge',
      location: 'San Francisco, CA',
      description:
          'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.'),
  AttractionModel(
      imgPath:
          'https://images.pexels.com/photos/5627275/pexels-photo-5627275.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
      name: 'Brooklyn Bridge',
      location: 'Brooklyn, NY',
      description:
          'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.'),
  AttractionModel(
      imgPath:
          'https://images.pexels.com/photos/5241381/pexels-photo-5241381.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
      name: 'London Bridge',
      location: 'London, UK',
      description:
          'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.'),
  AttractionModel(
      imgPath:
          'https://images.pexels.com/photos/1680247/pexels-photo-1680247.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      name: 'Harbour Bridge',
      location: 'Sydney, AU',
      description:
          'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.')
];

final List<BottomBarModel> bottomBarListItems = [
  BottomBarModel(icon: Icons.explore_outlined, isSelected: true),
  BottomBarModel(icon: Icons.favorite_border, isSelected: false),
  BottomBarModel(icon: Icons.comment_outlined, isSelected: false),
  BottomBarModel(icon: Icons.account_circle_outlined, isSelected: false),
];

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryGray,
        iconTheme: IconThemeData(color: mainYellow),
        title: Center(
          child: Icon(
            Icons.airplanemode_on,
            color: mainYellow,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_on_outlined,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: mainYellow,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(20),
          child: const Icon(
            Icons.airplanemode_on,
            size: 80,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryGray,
              secondaryGray,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderWidget(),
            const AttractionListView(),
            BottomBarWidget(),
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 30,
            right: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Where do you',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'want to go?',
                style: TextStyle(
                  color: mainYellow,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: lightGray,
            ),
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                SizedBox(width: 10),
                Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AttractionListView extends StatelessWidget {
  const AttractionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 10),
        itemCount: attractions.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          AttractionModel currentAttraction = attractions[index];
          return AttractionCard(attractionModel: currentAttraction);
        },
      ),
    );
  }
}

class AttractionCard extends StatelessWidget {
  AttractionCard({this.attractionModel, super.key});

  AttractionModel? attractionModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsPage(
                  selectedModel: attractionModel,
                )));
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(attractionModel!.imgPath!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          attractionModel!.name!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          attractionModel!.location!,
                          style: TextStyle(color: mainYellow),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBarWidget extends StatefulWidget {
  @override
  State<BottomBarWidget> createState() => BottomBarWidgetState();
}

class BottomBarWidgetState extends State<BottomBarWidget> {
  final List<BottomBarModel> _bottomBarItems = bottomBarListItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _bottomBarItems.length,
          (index) {
            var barItemWidget = _bottomBarItems[index];
            return IconButton(
              icon: Icon(
                barItemWidget.icon,
                color: barItemWidget.isSelected! ? mainYellow : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _bottomBarItems.forEach((element) {
                    element.isSelected = element == barItemWidget;
                  });
                });
              },
            );
          },
        ),
      ),
    );
  }
}

class AttractionModel {
  String? imgPath;
  String? name;
  String? location;
  String? description;

  AttractionModel({
    this.imgPath,
    this.name,
    this.location,
    this.description,
  });
}

class BottomBarModel {
  IconData? icon;
  bool? isSelected;

  BottomBarModel({this.icon, this.isSelected});
}
