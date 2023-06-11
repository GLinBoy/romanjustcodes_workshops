import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romanjustcodes_workshops/pages/architect/splash/splash.dart';

class DonutMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DonutPager(),
        DonutFilterBar(),
        Expanded(
          child: Consumer<DonutService>(
            builder: (context, donutService, child) {
              return DonutList(donuts: donutService.filteredDonuts);
            },
          ),
        ),
      ],
    );
  }
}

class DonutPager extends StatefulWidget {
  @override
  State<DonutPager> createState() => _DonutPagerState();
}

class _DonutPagerState extends State<DonutPager> {
  List<DonutPage> pages = [
    DonutPage(imgUrl: Utils.donutPromo1, logoImgUrl: Utils.donutLogoWhiteText),
    DonutPage(imgUrl: Utils.donutPromo2, logoImgUrl: Utils.donutLogoWhiteText),
    DonutPage(imgUrl: Utils.donutPromo3, logoImgUrl: Utils.donutLogoRedText),
  ];

  int currentPage = 0;
  PageController? controller;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              controller: controller,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              children: List.generate(
                pages.length,
                (index) {
                  DonutPage currentPage = pages[index];
                  return Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0.0, 5.0),
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(currentPage.imgUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Image.network(
                      currentPage.logoImgUrl!,
                      width: 120,
                    ),
                  );
                },
              ),
            ),
          ),
          PageViewIndicator(
            controller: controller,
            numberOfPages: pages.length,
            currentPage: currentPage,
          ),
        ],
      ),
    );
  }
}

class PageViewIndicator extends StatelessWidget {
  PageController? controller;
  int? numberOfPages;
  int? currentPage;

  PageViewIndicator({
    this.controller,
    this.numberOfPages,
    this.currentPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        numberOfPages!,
        (index) {
          return GestureDetector(
            onTap: () {
              controller!.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(microseconds: 250),
              curve: Curves.easeInOut,
              width: 15,
              height: 15,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: currentPage == index
                    ? Utils.mainColor
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DonutFilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Consumer<DonutService>(
        builder: (context, donutService, child) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  donutService.filterBarItems.length,
                  (index) {
                    DonutFilterBarItem item =
                        donutService.filterBarItems[index];
                    return GestureDetector(
                      onTap: () {
                        donutService.filteredDonutsByType(item.id!);
                      },
                      child: Container(
                        child: Text(
                          '${item.label!}',
                          style: TextStyle(
                            color: donutService.selectedDonutType == item.id
                                ? Utils.mainColor
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(microseconds: 250),
                    curve: Curves.easeInOut,
                    alignment:
                        alignmentBasedOnTap(donutService.selectedDonutType),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3 - 20,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Utils.mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Alignment alignmentBasedOnTap(filterBarId) {
    switch (filterBarId) {
      case 'classic':
        return Alignment.centerLeft;
      case 'sprinkled':
        return Alignment.center;
      case 'stuffed':
        return Alignment.centerRight;
      default:
        return Alignment.centerLeft;
    }
  }
}

class DonutService extends ChangeNotifier {
  List<DonutFilterBarItem> filterBarItems = [
    DonutFilterBarItem(id: 'classic', label: 'Classic'),
    DonutFilterBarItem(id: 'sprinkled', label: 'Sprinkled'),
    DonutFilterBarItem(id: 'stuffed', label: 'Stuffed'),
  ];

  String? selectedDonutType;
  List<DonutModel> filteredDonuts = [];
  late DonutModel selectedDonut;

  DonutModel getSelectedDonut() {
    return selectedDonut;
  }

  void onDonutSelected(DonutModel donut) {
    selectedDonut = donut;
    Utils.mainAppNav.currentState!.pushNamed('/details');
  }

  DonutService() {
    selectedDonutType = filterBarItems.first.id;
    filteredDonutsByType(selectedDonutType!);
  }

  void filteredDonutsByType(String type) {
    selectedDonutType = type;
    filteredDonuts =
        Utils.donuts.where((d) => d.type == selectedDonutType).toList();
    notifyListeners();
  }
}

class DonutList extends StatefulWidget {
  List<DonutModel>? donuts;

  DonutList({this.donuts});

  @override
  State<DonutList> createState() => _DonutListState();
}

class _DonutListState extends State<DonutList> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<DonutModel> insertedItems = [];

  @override
  void initState() {
    super.initState();
    var future = Future(() {});
    for (var i = 0; i < widget.donuts!.length; i++) {
      future = future.then((_) {
        return Future.delayed(const Duration(microseconds: 125), () {
          insertedItems.add(widget.donuts![i]);
          _key.currentState!.insertItem(i);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _key,
      scrollDirection: Axis.horizontal,
      initialItemCount: insertedItems.length,
      itemBuilder: (context, index, animation) {
        DonutModel currentDonut = widget.donuts![index];
        return SlideTransition(
          position: Tween(
            begin: const Offset(0.2, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: DonutCard(donutInfo: currentDonut),
          ),
        );
      },
    );
  }
}

class DonutCard extends StatelessWidget {
  DonutModel? donutInfo;
  DonutCard({this.donutInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var donutService = Provider.of<DonutService>(context, listen: false);
        donutService.onDonutSelected(donutInfo!);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            padding: const EdgeInsets.all(15),
            alignment: Alignment.bottomLeft,
            margin:
                const EdgeInsets.only(left: 10, top: 80, right: 10, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${donutInfo!.name}',
                  style: const TextStyle(
                    color: Utils.mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Utils.mainColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Text(
                    '\$${donutInfo!.price!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.network(
              donutInfo!.imgUrl!,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class DonutPage {
  String? imgUrl;
  String? logoImgUrl;

  DonutPage({this.imgUrl, this.logoImgUrl});
}

class DonutFilterBarItem {
  String? id;
  String? label;

  DonutFilterBarItem({this.id, this.label});
}

class DonutModel {
  String? imgUrl;
  String? name;
  String? description;
  double? price;
  String? type;

  DonutModel({
    this.imgUrl,
    this.name,
    this.description,
    this.price,
    this.type,
  });
}
