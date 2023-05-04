import 'package:flutter/material.dart';
import 'splash/splash.dart';
import 'landing/landing.dart';
import 'detail/detail.dart';

final List<PageItem> pageItems = [
  PageItem(label: 'Splash', page: SplashPage()),
  PageItem(label: 'Landing', page: LandingPage()),
  PageItem(label: 'Detail', page: DetailPage()),
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
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: 2,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: pageItems.length,
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
