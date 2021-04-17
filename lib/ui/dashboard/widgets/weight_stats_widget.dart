import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';

class WeightStatsWidget extends StatefulWidget {
  WeightStatsWidget() : super();

  @override
  _WeightStatsWidgetState createState() => _WeightStatsWidgetState();
}

class _WeightStatsWidgetState extends State<WeightStatsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      return BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
        if (state is DashboardLoaded) {
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
                        ((state.targetWeight - state.measurement.weightEntry) *
                                -1)
                            .toString(),
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
