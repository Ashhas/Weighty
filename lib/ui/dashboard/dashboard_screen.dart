import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/ui/common/common_app_bar.dart';
import 'package:weighty/ui/dashboard/widgets/weight_progress_container.dart';
import 'package:weighty/ui/dashboard/widgets/weight_statistics_widget.dart';
import 'package:weighty/util/constants/ui_const.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen() : super();

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Setup Dashboard Screen
    BlocProvider.of<DashboardBloc>(context).add(DashboardStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(appBarTitle: UiConst.statisticsTitle),
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        children: [
          WeightProgressContainer(),
          SizedBox(height: 15),
          WeightStatisticsWidget(),
        ],
      ),
    );
  }
}
