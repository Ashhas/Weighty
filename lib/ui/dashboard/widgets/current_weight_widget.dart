import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../util/strings.dart';

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
            radius: 140.0,
            lineWidth: 8.0,
            animation: true,
            percent: state.percentageDone / 100,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.measurement.weightEntry.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      " KG",
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Text(
                  GlobalStrings.weightCurrentTitle,
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Theme.of(context).accentColor,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
