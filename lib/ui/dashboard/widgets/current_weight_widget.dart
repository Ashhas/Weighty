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
            percent: state.percentageDone,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.measurement.weightEntry.toString(),
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      " KG",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Text(
                  UiConst.weightCurrentTitle,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
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
