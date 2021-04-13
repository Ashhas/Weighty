import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class WeightStatsWidget extends StatefulWidget {
  final double targetWeight;
  final double startWeight;

  WeightStatsWidget({this.targetWeight, this.startWeight}) : super();

  @override
  _WeightStatsWidgetState createState() => _WeightStatsWidgetState();
}

class _WeightStatsWidgetState extends State<WeightStatsWidget> {
  double startWeight = 0;
  double targetWeight = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      return BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
        if (state is DashboardLoaded) {
          // measurement = widget.dataBox.values.last;
          if (widget.startWeight != null) {
            startWeight = widget.startWeight;
            targetWeight = widget.targetWeight;
          }
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Column(
                      children: [
                        Text(
                          "172.4",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          "MOVING AVG",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Column(
                    children: [
                      Text(
                        "1.4",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(
                        "AVG. WEEKLY LOSS",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  Divider(),
                  Column(
                    children: [
                      Text(
                        state.measurement != null
                            ? ((targetWeight - state.measurement.weightEntry) *
                                    -1)
                                .toString()
                            : "-",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(
                        "LEFT TO GO",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ],
              ));
        } else {
          return Container();
        }
      });
    });
  }
}
