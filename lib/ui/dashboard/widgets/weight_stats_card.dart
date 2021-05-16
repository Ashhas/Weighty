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
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "1.4",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            " KG",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              // color: Colors.white,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "This Week",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                Divider(),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          state.totalLost.toString(),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          " KG",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            // color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Total Lost",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          state.amountLeft.toString(),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          " KG",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            // color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "LEFT TO GO",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      });
    });
  }
}
