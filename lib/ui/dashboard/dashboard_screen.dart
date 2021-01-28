import 'package:weighty/bloc/home/navigation_bloc.dart';
import 'package:weighty/ui/dashboard/widgets/latest_weight_stats_widget.dart';
import 'package:weighty/ui/dashboard/widgets/latest_weight_widget.dart';
import 'package:weighty/ui/dashboard/widgets/start_weight_widget.dart';
import 'package:weighty/ui/dashboard/widgets/target_weight_widget.dart';
import 'package:weighty/util/strings.dart';
import 'package:weighty/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  final Box dataBox;

  const DashboardScreen({this.dataBox}) : super();

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String personName;
  double startWeight;
  String startWeightDate;
  double targetWeight;
  String targetWeightDate;

  @override
  void initState() {
    super.initState();

    _getPrefsData();
  }

  Future _getPrefsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      personName = prefs.getString(GlobalStrings.userName);
      startWeightDate = prefs.getString(GlobalStrings.userStartWeightDate);
      startWeight = prefs.getDouble(GlobalStrings.userStartWeight);
      targetWeightDate = prefs.getString(GlobalStrings.userTargetWeightDate);
      targetWeight = prefs.getDouble(GlobalStrings.userTargetWeight);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppThemes.backgroundColor,
          title: Column(
            children: [
              Text(
                personName ?? "",
                style: AppThemes.screenTitleTxtStyle,
              ),
              Text(
                GlobalStrings.dashboardLabel,
                style: AppThemes.screenLabelTxtStyle,
              )
            ],
          ),
          centerTitle: true,
        ),
        body: BlocListener<NavigationBloc, NavigationState>(
          listener: (context, state) {
            print(state);
            if (state is DashboardOpenedState) {
              _getPrefsData();
            }
          },
          child: Container(
            color: AppThemes.backgroundColor,
            child: Column(
              children: [
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: StartWeightWidget(
                          startWeight: startWeight,
                          startWeightDate: startWeightDate,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TargetWeightWidget(
                          targetWeight: targetWeight,
                          targetWeightDate: targetWeightDate,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: LatestWeightWidget(
                          dataBox: widget.dataBox,
                          targetWeight: targetWeight,
                          startWeight: startWeight,
                        ),
                      )
                    ],
                  ),
                ),
                LatestWeightStatsWidget(
                  dataBox: widget.dataBox,
                  targetWeight: targetWeight,
                  startWeight: startWeight,
                ),
              ],
            ),
          ),
        ));
  }
}
