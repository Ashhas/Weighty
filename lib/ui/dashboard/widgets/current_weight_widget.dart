import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weighty/util/constants/ui_const.dart';

class CurrentWeightWidget extends StatefulWidget {
  CurrentWeightWidget() : super();

  @override
  _CurrentWeightWidgetState createState() => _CurrentWeightWidgetState();
}

class _CurrentWeightWidgetState extends State<CurrentWeightWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (BuildContext context, state) {
        if (state is DashboardLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                UiConst.weightCurrentTitle,
                style: Theme.of(context).primaryTextTheme.subtitle1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state.measurement != null
                      ? Text(
                          state.measurement.weightEntry.toString(),
                          style: Theme.of(context).primaryTextTheme.headline1,
                        )
                      : Text(
                          UiConst.noWeightValue,
                          style: Theme.of(context).primaryTextTheme.headline1,
                        ),
                  SizedBox(width: 4),
                  Text(
                    state.unitType,
                    style: Theme.of(context).primaryTextTheme.headline4,
                  ),
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
