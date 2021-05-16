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
              Row(
                children: [
                  Text(
                    state.targetWeight.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
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
              ),
              Text(
                GlobalStrings.weightTargetTitle,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  // color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                ),
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
