import 'package:flutter/material.dart';
import 'package:weighty/ui/dashboard/widgets/statistic_card.dart';
import 'package:weighty/util/constants/ui_const.dart';

class StatisticGrid extends StatelessWidget {
  final double percentageDone;
  final double totalLost;
  final double amountLeft;
  final String unitType;

  const StatisticGrid(
      {Key key,
      this.percentageDone,
      this.totalLost,
      this.amountLeft,
      this.unitType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 1 / 0.5,
        children: [
          StatisticCard(
            cardTitle: UiConst.completedStatItemTitle,
            cardValue: "${(percentageDone * 100).toStringAsFixed(2)}%",
            unitType: unitType,
            cardIcon: Icons.check_circle_outline,
          ),
          StatisticCard(
            cardTitle: UiConst.weightLostStatItemTitle,
            cardValue: "${totalLost.toStringAsFixed(2)} $unitType",
            unitType: unitType,
            cardIcon: Icons.arrow_circle_down,
          ),
          StatisticCard(
            cardTitle: UiConst.weightLeftStatItemTitle,
            cardValue: "${amountLeft.toStringAsFixed(2)} $unitType",
            unitType: unitType,
            cardIcon: Icons.timeline,
          ),
        ],
      ),
    );
  }
}
