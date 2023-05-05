import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/landing/landing.dart';
import 'package:romanjustcodes_workshops/pages/splash/splash.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedItem = mountItems[3];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(selectedItem.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 30,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedItem.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          selectedItem.location,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    iconTheme: IconThemeData(color: Colors.white),
                    title: Center(
                      child: Icon(
                        Icons.terrain,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    actions: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.pending,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                DetailsRatingBar(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        child: Text(
                          'About ${selectedItem.name}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        child: Text(
                          '${selectedItem.description}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsRatingBar extends StatelessWidget {
  var sampleRatingData = {
    'Rating': '4.6',
    'Price': '\$12',
    'Open': '24Hrs',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          sampleRatingData.entries.length,
          (index) => Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  sampleRatingData.entries.elementAt(index).key,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  sampleRatingData.entries.elementAt(index).value,
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
