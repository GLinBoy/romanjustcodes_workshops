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
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0.0, 5.0),
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
              margin: EdgeInsets.all(10),
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
      padding: EdgeInsets.all(20),
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
              SizedBox(height: 10),
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

  DonutService() {
    selectedDonutType = filterBarItems.first.id;
  }

  void filteredDonutsByType(String type) {
    selectedDonutType = type;
    notifyListeners();
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
