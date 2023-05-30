import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romanjustcodes_workshops/pages/architect/details/details.dart';
import 'layout_part1/splash/splash.dart' as sp_pt1;
import 'layout_part2/splash/splash.dart' as sp_pt2;
import 'layout_part3/splash/splash.dart' as sp_pt3;
import 'architect/splash/splash.dart' as sp_architect;
import 'architect/main/main.dart' as sp_architect_main;

final List<PageItem> pageItems = [
  PageItem(label: 'Layout Pt.1', page: const sp_pt1.SplashPage()),
  PageItem(label: 'Layout Pt.2', page: sp_pt2.SplashPage()),
  PageItem(label: 'Layout Pt.3', page: sp_pt3.SplashPage()),
  PageItem(
    label: 'Architect',
    page: MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sp_architect.DonutBottomBarSelectionService(),
        ),
        ChangeNotifierProvider(
          create: (_) => sp_architect_main.DonutService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        navigatorKey: sp_architect.Utils.mainAppNav,
        routes: {
          // '/': (context) => sp_architect.SplashPage(),
          '/': (context) => DonutShopDetails(),
          '/main': (context) => sp_architect.DonutShopMain(),
        },
      ),
    ),
  ),
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
