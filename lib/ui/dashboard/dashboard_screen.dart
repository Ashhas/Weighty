import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/ui/dashboard/widgets/weight_progress_card.dart';
import 'package:weighty/ui/dashboard/widgets/weight_stats_card.dart';

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
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        children: [
          SizedBox(height: 15),
          WeightProgressCard(),
          SizedBox(height: 15),
          WeightStatsWidget(),
        ],
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).canvasColor,
      title: Text(
        "Weighty",
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }
}
