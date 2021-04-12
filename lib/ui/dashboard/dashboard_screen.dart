import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:weighty/bloc/app_init/initialization_bloc.dart';
import 'package:weighty/ui/dashboard/widgets/small_weight_chart_widget.dart';
import 'package:weighty/ui/dashboard/widgets/weight_stats_widget.dart';
import 'package:weighty/ui/dashboard/widgets/weight_progress_card.dart';
import 'package:weighty/util/shared_pref_service.dart';
import 'package:weighty/util/strings.dart';

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
    final sharedPrefService = await SharedPreferencesService.instance;

    setState(() {
      personName = sharedPrefService.getUsername;
      startWeight = sharedPrefService.getStartWeight;
      startWeightDate = sharedPrefService.getStartWeightDate;
      targetWeight = sharedPrefService.getTargetWeight;
      targetWeightDate = sharedPrefService.getTargetWeightDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Column(
            children: [
              Text(
                personName ?? "",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                GlobalStrings.dashboardLabel,
                style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
          centerTitle: true,
        ),
        body: BlocListener<InitializationBloc, InitializationState>(
          listener: (context, state) {
            if (state is Initialized) {
              _getPrefsData();
            }
          },
          child: Container(
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    WeightProgressCard(
                      dataBox: widget.dataBox,
                      targetWeight: targetWeight,
                      startWeight: startWeight,
                      targetWeightDate: targetWeightDate,
                      startWeightDate: startWeightDate,
                    ),
                    SizedBox(height: 5),
                    WeightStatsWidget(
                      dataBox: widget.dataBox,
                      targetWeight: targetWeight,
                      startWeight: startWeight,
                    ),
                    SizedBox(height: 5),
                    SmallWeightChartWidget()
                  ],
                ),
              )),
        ));
  }
}
