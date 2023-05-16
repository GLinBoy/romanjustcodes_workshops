import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/layout_part3/splash/splash.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.bottomLeft,
          child: const Icon(
            Icons.pool,
            color: mainThemeColor,
            size: 80,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('<BG_IMAGE_PATH>'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: mainThemeColor.withOpacity(0.7),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Paradise',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 60),
              const Icon(
                Icons.pool,
                color: Colors.white,
                size: 80,
              ),
              const SizedBox(height: 10),
              Text(
                'Choose location to'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Find a Hotel',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              LandingSearchBar(),
            ],
          ),
        ],
      ),
    );
  }
}

class LandingSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 20,
        right: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Search hotel',
            style: TextStyle(color: Colors.grey),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ListPage()),
              );
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: mainThemeColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.search,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
