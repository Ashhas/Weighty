import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/util/strings.dart';
import 'package:flutter/material.dart';

class TargetWeightWidget extends StatefulWidget {
  TargetWeightWidget() : super();

  @override
  _TargetWeightWidgetState createState() => _TargetWeightWidgetState();
}

class _TargetWeightWidgetState extends State<TargetWeightWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (BuildContext context, state) {
        if (state is DashboardLoaded) {
          return Column(
            children: [
              Text(
                GlobalStrings.weightTargetTitle,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                state.targetWeight.toString(),
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                state.targetWeightDate,
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
