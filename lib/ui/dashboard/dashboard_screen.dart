import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/ui/dashboard/widgets/small_weight_chart_widget.dart';
import 'package:weighty/ui/dashboard/widgets/weight_progress_card.dart';
import 'package:weighty/util/strings.dart';

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
    return Scaffold(body:
        BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
      if (state is DashboardLoaded) {
        return Container(
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  _buildAppBar(state.username),
                  SizedBox(height: 15),
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

  _buildAppBar(String username) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      title: Column(
        children: [
          Text(
            username,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            GlobalStrings.dashboardLabel,
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      ),
      centerTitle: true,
    );
  }
}
