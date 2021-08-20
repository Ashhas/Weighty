import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:weighty/util/constants/ui_const.dart';

class CurrentWeightWidget extends StatefulWidget {
  CurrentWeightWidget() : super();

  @override
  _CurrentWeightWidgetState createState() => _CurrentWeightWidgetState();
}

class _CurrentWeightWidgetState extends State<CurrentWeightWidget>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (BuildContext context, state) {
        if (state is DashboardLoaded) {
          return CircularPercentIndicator(
            radius: 150.0,
            lineWidth: 4.0,
            animation: true,
            percent: state.percentageDone != null ? state.percentageDone : 0.0,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state.measurement != null
                        ? Text(
                            state.measurement.weightEntry.toString(),
                            style: Theme.of(context).primaryTextTheme.headline1,
                          )
                        : Text(
                            " - ",
                            style: Theme.of(context).primaryTextTheme.headline1
                          ),
                    SizedBox(width: 4),
                    Text(
                      state.unitType,
                      style: Theme.of(context).primaryTextTheme.headline4
                    ),
                  ],
                ),
                Text(
                  UiConst.weightCurrentTitle,
                  style: Theme.of(context).primaryTextTheme.subtitle1
                ),
              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.white,
            backgroundColor: Colors.grey.withOpacity(0.5),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
