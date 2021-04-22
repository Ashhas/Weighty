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
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: _buildAppBar(),
        body: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
          if (state is DashboardLoaded) {
            return Padding(
                padding: EdgeInsets.only(left: 23, right: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    _buildNameWidget(),
                    SizedBox(height: 20),
                    WeightProgressCard(),
                    SizedBox(height: 5),
                    SmallWeightChartWidget(),
                  ],
                ));
          } else {
            return Container();
          }
        }));
  }

  _buildAppBar() {
    return AppBar(
        elevation: 0,
        leadingWidth: 120,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 23, top: 35),
          child:
              Text(DateFormat.yMMMd('en_US').format(DateTime.now()).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600,
                  )),
        ));
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
                fontSize: 28,
                color: Colors.black,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        )
      ],
    );
  }
}
