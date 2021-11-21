import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/ui/dashboard/widgets/chart_widget.dart';
import 'package:weighty/util/constants/ui_const.dart';

class WeightStatsWidget extends StatefulWidget {
  WeightStatsWidget() : super();

  @override
  _WeightStatsWidgetState createState() => _WeightStatsWidgetState();
}

class _WeightStatsWidgetState extends State<WeightStatsWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state is DashboardLoaded) {
                      return IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              _titleView(
                                  titleName: UiConst.cardStatisticsTitle),
                              Container(
                                height: 180,
                                child: GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  childAspectRatio: 1 / 0.5,
                                  children: [
                                    statCard(
                                      cardTitle: UiConst.completedStatItemTitle,
                                      cardValue:
                                          "${(state.percentageDone * 100).toStringAsFixed(2)}%",
                                      unitType: state.unitType,
                                      cardIcon: Icons.check_circle_outline,
                                    ),
                                    statCard(
                                      cardTitle:
                                          UiConst.weightLostStatItemTitle,
                                      cardValue:
                                          "${state.totalLost.toStringAsFixed(2)} ${state.unitType}",
                                      unitType: state.unitType,
                                      cardIcon: Icons.exposure_minus_1,
                                    ),
                                    statCard(
                                      cardTitle:
                                          UiConst.weightLeftStatItemTitle,
                                      cardValue:
                                          "${state.amountLeft.toStringAsFixed(2)} ${state.unitType}",
                                      unitType: state.unitType,
                                      cardIcon: Icons.alternate_email,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              _titleView(
                                  titleName: UiConst.cardWeightGraphTitle),
                              SizedBox(height: 5),
                              SmallWeightChartWidget(),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _titleView({String titleName}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        height: 25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(titleName,
                style: Theme.of(context).primaryTextTheme.headline3),
          ],
        ),
      ),
    );
  }

  Widget statCard(
      {String cardTitle,
      String cardValue,
      String unitType,
      IconData cardIcon}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.grey,
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
                Icon(cardIcon),
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
