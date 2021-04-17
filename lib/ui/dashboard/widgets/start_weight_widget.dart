import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/util/strings.dart';
import 'package:flutter/material.dart';

class StartWeightWidget extends StatefulWidget {
  StartWeightWidget() : super();

  @override
  _StartWeightWidgetState createState() => _StartWeightWidgetState();
}

class _StartWeightWidgetState extends State<StartWeightWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (BuildContext context, state) {
        if (state is DashboardLoaded) {
          return Column(
            children: [
              Text(
                GlobalStrings.weightStartedTitle,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                state.startWeight.toString(),
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                state.startWeightDate,
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
