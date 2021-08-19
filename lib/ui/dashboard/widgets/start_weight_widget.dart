import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/util/constants/ui_const.dart';
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
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      state.startWeight.toString(),
                      style: Theme.of(context).primaryTextTheme.headline2
                    ),
                    SizedBox(width: 4),
                    Text(
                      state.unitType,
                      style: Theme.of(context).primaryTextTheme.headline4
                    ),
                  ],
                ),
                Text(
                  UiConst.weightStartedTitle,
                  style: Theme.of(context).primaryTextTheme.subtitle1
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
