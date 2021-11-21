import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:weighty/util/constants/ui_const.dart';

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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(UiConst.weightTargetTitle,
                  style: Theme.of(context).primaryTextTheme.subtitle1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state.targetWeight != null
                      ? Text(
                          state.targetWeight.toString(),
                          style: Theme.of(context).primaryTextTheme.headline1,
                        )
                      : Text(" - ",
                          style: Theme.of(context).primaryTextTheme.headline1),
                  SizedBox(width: 4),
                  Text(state.unitType,
                      style: Theme.of(context).primaryTextTheme.headline4),
                ],
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
