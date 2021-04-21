import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../util/strings.dart';

class LatestWeightWidget extends StatefulWidget {
  LatestWeightWidget() : super();

  @override
  _CurrentWeightWidgetState createState() => _CurrentWeightWidgetState();
}

class _CurrentWeightWidgetState extends State<LatestWeightWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (BuildContext context, state) {
        if (state is DashboardLoaded) {
          return Column(
            children: [
              Text(
                "Last Weigh-in: ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  // color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                DateFormat.yMMMd('en_US')
                    .format(
                        DateTime.parse(state.measurement.dateAdded.toString()))
                    .toString(),
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  // color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
