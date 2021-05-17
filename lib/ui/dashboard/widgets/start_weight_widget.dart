import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
              Row(
                children: [
                  Text(
                    state.startWeight.toString(),
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.grey,
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
                GlobalStrings.weightStartedTitle,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: Colors.grey,
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
