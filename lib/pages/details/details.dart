import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Text('Details Top'),
          ),
          Expanded(
            child: Text('Details Bottom'),
          ),
        ],
      ),
    );
  }
}
