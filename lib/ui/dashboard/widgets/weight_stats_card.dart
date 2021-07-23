import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/ui/dashboard/widgets/small_weight_chart_widget.dart';

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
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 25),
                            _titleView(titleName: "Statistics"),
                            _simpleStatsRow(
                                totalLost: state.totalLost,
                                amountLeft: state.amountLeft,
                                percentageCompleted: state.percentageDone,
                                unitType: state.unitType),
                            SizedBox(height: 15),
                            _titleView(titleName: "Weight Graph"),
                            SmallWeightChartWidget(),
                          ],
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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(titleName,
                style: Theme.of(context).primaryTextTheme.headline6),
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
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                      percentageCompleted != null
                          ? (percentageCompleted * 100).round().toString()
                          : "-",
                      style: Theme.of(context).primaryTextTheme.bodyText2),
                  Text("%",
                      style: Theme.of(context).primaryTextTheme.bodyText2),
                ],
              ),
              Text("Completed",
                  style: Theme.of(context).primaryTextTheme.bodyText2),
            ],
          ),
          Divider(),
          Column(
            children: [
              Row(
                children: [
                  Text(totalLost != null ? totalLost.toStringAsFixed(2) : "-",
                      style: Theme.of(context).primaryTextTheme.bodyText2),
                  SizedBox(width: 4),
                  Text(
                    unitType,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Text("Total Lost",
                  style: Theme.of(context).primaryTextTheme.bodyText2),
            ],
          ),
          Divider(),
          Column(
            children: [
              Row(
                children: [
                  Text(amountLeft != null ? amountLeft.toStringAsFixed(2) : "-",
                      style: Theme.of(context).primaryTextTheme.bodyText2),
                  SizedBox(width: 4),
                  Text(
                    unitType,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Text("Left to Go",
                  style: Theme.of(context).primaryTextTheme.bodyText2),
            ],
          ),
        ],
      ),
    );
  }
}
