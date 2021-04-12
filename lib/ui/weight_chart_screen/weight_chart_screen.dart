import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/strings.dart';
import 'package:weighty/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class WeightChartScreen extends StatefulWidget {
  final Box dataBox;

  const WeightChartScreen({this.dataBox}) : super();

  @override
  _AddWeightScreenState createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<WeightChartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Column(
            children: [
              Text(
                GlobalStrings.weightChartTitle,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Container());
  }
}
