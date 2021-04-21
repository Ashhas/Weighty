import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../util/strings.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                GlobalStrings.weightCurrentTitle,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  // color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    state.measurement.weightEntry.toString(),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      // color: Colors.white,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    " KG",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      // color: Colors.white,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
