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
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                DateFormat.yMMMd('en_US')
                    .format(
                        DateTime.parse(state.measurement.dateAdded.toString()))
                    .toString(),
                style: Theme.of(context).textTheme.bodyText2,
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
