import 'package:flutter/material.dart';
import 'package:romanjustcodes_workshops/pages/architect/main/main.dart';
import 'package:romanjustcodes_workshops/pages/architect/splash/splash.dart';

class DonutShoppingListRow extends StatelessWidget {
  DonutModel? donut;
  Function? onDeleteRow;

  DonutShoppingListRow({this.donut, required this.onDeleteRow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
      child: Row(
        children: [
          Image.network(
            '${donut!.imgUrl}',
            width: 80,
            height: 80,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${donut!.name}',
                  style: TextStyle(
                    color: Utils.mainColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 2,
                      color: Utils.mainDark.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    '\$${donut!.price!.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Utils.mainDark.withOpacity(0.4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {
              onDeleteRow!();
            },
            icon: Icon(
              Icons.delete_forever,
              color: Utils.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
