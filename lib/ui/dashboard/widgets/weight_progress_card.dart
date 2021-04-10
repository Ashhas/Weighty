import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../util/theme.dart';
import '../../../util/theme.dart';
import 'current_weight_widget.dart';
import 'start_weight_widget.dart';
import 'target_weight_widget.dart';

class WeightProgressCard extends StatefulWidget {
  final Box dataBox;
  final double targetWeight;
  final double startWeight;
  final String targetWeightDate;
  final String startWeightDate;

  WeightProgressCard(
      {this.dataBox,
      this.targetWeight,
      this.startWeight,
      this.targetWeightDate,
      this.startWeightDate})
      : super();

  @override
  _WeightProgressCardState createState() => _WeightProgressCardState();
}

class _WeightProgressCardState extends State<WeightProgressCard> {
  MeasurementModel measurement;
  double startWeight = 0;
  double targetWeight = 0;
  String startWeightDate;
  String targetWeightDate;
  double percentageDone = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.dataBox != null) {
      measurement = widget.dataBox.values.last;
      if (widget.startWeight != null) {
        startWeight = widget.startWeight;
        targetWeight = widget.targetWeight;
        startWeightDate = widget.startWeightDate;
        targetWeightDate = widget.targetWeightDate;

        var amountToLose = startWeight - targetWeight;
        percentageDone = ((widget.startWeight - measurement.weightEntry) *
            100 /
            amountToLose);
      }
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Text(
            "Weight Loss Progress",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                measurement != null ? percentageDone.toInt().toString() : "-",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                "% Completed",
                style: TextStyle(color: Theme.of(context).shadowColor),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StartWeightWidget(
                startWeight: startWeight,
                startWeightDate: startWeightDate,
              ),
              CurrentWeightWidget(
                dataBox: widget.dataBox,
                targetWeight: targetWeight,
                startWeight: startWeight,
              ),
              TargetWeightWidget(
                targetWeight: targetWeight,
                targetWeightDate: targetWeightDate,
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: LinearProgressIndicator(
              value: percentageDone / 100,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              backgroundColor: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
