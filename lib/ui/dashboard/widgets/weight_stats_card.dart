import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/ui/dashboard/widgets/chart_widget.dart';

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
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state is DashboardLoaded) {
                      return IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Column(
                            children: [
                              _titleView(titleName: "Statistics"),
                              _simpleStatsRow(
                                  totalLost: state.totalLost,
                                  amountLeft: state.amountLeft,
                                  percentageCompleted: state.percentageDone,
                                  unitType: state.unitType),
                              SizedBox(height: 30),
                              _titleView(titleName: "Weight Graph"),
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

  Widget _simpleStatsRow(
      {double totalLost,
      double amountLeft,
      double percentageCompleted,
      String unitType}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _statItemPercentage(
          numberValue: percentageCompleted,
          itemTitle: "Completed",
        ),
        Divider(),
        _statItemGeneral(
          numberValue: totalLost,
          unitType: unitType,
          itemTitle: "Total Lost",
        ),
        Divider(),
        _statItemGeneral(
          numberValue: amountLeft,
          unitType: unitType,
          itemTitle: "Left to Go",
        ),
      ]),
    );
  }

  Widget _statItemPercentage({double numberValue, String itemTitle}) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
                shape: BoxShape.circle,
              ),
            ),
            Row(
              children: [
                Text(
                    numberValue != null
                        ? (numberValue * 100).round().toString()
                        : "-",
                    style: Theme.of(context).primaryTextTheme.headline5),
                SizedBox(width: 3),
                Text("%", style: Theme.of(context).primaryTextTheme.headline5),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(itemTitle, style: Theme.of(context).primaryTextTheme.subtitle2),
      ],
    );
  }

  Widget _statItemGeneral(
      {double numberValue, String unitType, String itemTitle}) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
                shape: BoxShape.circle,
              ),
            ),
            Row(
              children: [
                Text(numberValue != null ? numberValue.toStringAsFixed(1) : "-",
                    style: Theme.of(context).primaryTextTheme.headline5),
                SizedBox(width: 3),
                Text(
                  unitType,
                  style: Theme.of(context).primaryTextTheme.headline4,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(itemTitle, style: Theme.of(context).primaryTextTheme.subtitle2),
      ],
    );
  }
}
