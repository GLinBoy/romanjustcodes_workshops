import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/layout_part2/landing/landing.dart';
import 'layout_part1/splash/splash.dart';

final List<PageItem> pageItems = [
  PageItem(label: 'Layout Pt.1', page: const SplashPage()),
  PageItem(label: 'Landing Pt.2', page: const LandingPage())
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: pageItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            return ElevatedButton(
              child: Text(pageItems[index].label!),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => pageItems[index].page!));
              },
            );
          },
        ),
      ),
    );
  }
}

class PageItem {
  IconData? icon;
  String? label;
  Widget? page;

  PageItem({this.icon, this.label, this.page});
}
