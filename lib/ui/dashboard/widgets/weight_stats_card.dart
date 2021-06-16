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
        if (state is DashboardLoaded) {
          return Flexible(
            fit: FlexFit.loose,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            _titleView(titleName: "Statistics"),
                            _simpleStatsRow(
                                totalLost: state.totalLost,
                                amountLeft: state.amountLeft,
                                amountLostThisWeek: state.amountLostThisWeek),
                            Divider(
                              height: 1,
                              thickness: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _titleView({String titleName}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(titleName,
                style: Theme.of(context).primaryTextTheme.headline6),
            Icon(Icons.arrow_forward_ios_sharp,
                color: Theme.of(context).buttonColor),
          ],
        ),
      ),
    );
  }

  Widget _simpleStatsRow(
      {double totalLost, double amountLeft, double amountLostThisWeek}) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    totalLost.toString(),
                    style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.subtitle2),
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
                    amountLostThisWeek.toString(),
                    style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.subtitle2),
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
                "Lost This Week",
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
                    amountLeft.toString(),
                    style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.subtitle2),
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
  }
}
