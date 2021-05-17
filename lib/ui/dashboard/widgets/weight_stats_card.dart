import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';

class WeightStatsWidget extends StatefulWidget {
  WeightStatsWidget() : super();

  @override
  _WeightStatsWidgetState createState() => _WeightStatsWidgetState();
}

class _WeightStatsWidgetState extends State<WeightStatsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoaded) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "1.4",
                                style: GoogleFonts.roboto(
                                    textStyle:
                                        Theme.of(context).textTheme.subtitle2),
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
                            "This Week",
                            style: GoogleFonts.roboto(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              state.totalLost.toString(),
                              style: GoogleFonts.roboto(
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle2),
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
                          "Total Lost",
                          style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.bodyText2),
                        ),
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              state.amountLeft.toString(),
                              style: GoogleFonts.roboto(
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle2),
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
                          "Left to Go",
                          style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.bodyText2),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
