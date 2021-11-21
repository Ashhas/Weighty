import 'package:flutter/material.dart';

class StatisticCard extends StatelessWidget {
  final String cardTitle;
  final String cardValue;
  final String unitType;
  final IconData cardIcon;

  const StatisticCard(
      {Key key, this.cardTitle, this.cardValue, this.unitType, this.cardIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Theme.of(context).canvasColor.withOpacity(0.90),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  cardTitle,
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  cardIcon,
                  color: Colors.white,
                ),
              ],
            ),
            Text(
              cardValue.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
