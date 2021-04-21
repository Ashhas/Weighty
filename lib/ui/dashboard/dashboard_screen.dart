import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/ui/dashboard/widgets/small_weight_chart_widget.dart';
import 'package:weighty/ui/dashboard/widgets/weight_progress_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen() : super();

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DashboardBloc>(context).add(DashboardStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
          if (state is DashboardLoaded) {
            return Container(
                color: Theme.of(context).backgroundColor,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNameWidget(),
                      SizedBox(height: 25),
                      WeightProgressCard(),
                      SizedBox(height: 5),
                      SmallWeightChartWidget(),
                    ],
                  ),
                ));
          } else {
            return Container();
          }
        }));
  }

  _buildNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Hey Aschwin!",
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
                // color: Colors.white,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        )
      ],
    );
  }

  _buildAppBar() {
    return AppBar(
        elevation: 0,
        toolbarHeight: 40,
        backgroundColor: Theme.of(context).backgroundColor,
        leadingWidth: 120,
        leading: Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child:
              Text(DateFormat.yMMMd('en_US').format(DateTime.now()).toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    // color: Colors.white,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w700,
                  )),
        ));
  }
}
