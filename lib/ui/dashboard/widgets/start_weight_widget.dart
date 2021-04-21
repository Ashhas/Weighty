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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                GlobalStrings.weightStartedTitle,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  // color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Text(
                    state.startWeight.toString(),
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
