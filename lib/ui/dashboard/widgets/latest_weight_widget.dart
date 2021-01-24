import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class LatestWeightWidget extends StatefulWidget {
  final Box dataBox;
  final double targetWeight;
  final double startWeight;

  LatestWeightWidget({this.dataBox, this.targetWeight, this.startWeight})
      : super();

  @override
  _LatestWeightWidgetState createState() => _LatestWeightWidgetState();
}

class _LatestWeightWidgetState extends State<LatestWeightWidget> {
  MeasurementModel measurement;
  double percentageDone = 0;
  double startWeight = 0;
  double targetWeight = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.dataBox != null) {
      measurement = widget.dataBox.values.last;

      if (widget.startWeight != null) {
        startWeight = widget.startWeight;
        targetWeight = widget.targetWeight;

        var amountToLose = startWeight - targetWeight;
        percentageDone = ((widget.startWeight - measurement.weightEntry) *
            100 /
            amountToLose);
      }
    }

    return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 40),
        child: Column(
          children: [
            Text(
              measurement != null ? measurement.weightEntry.toString() : "-",
              style: AppThemes.currentWeightTxtStyle,
            ),
            Text(
              measurement != null
                  ? new DateFormat.yMMMd('en_US').format(measurement.dateAdded)
                  : "-",
              style: AppThemes.weightNumberMediumTxtStyle,
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      measurement != null
                          ? percentageDone.toInt().toString()
                          : "-",
                      style: AppThemes.weightNumberBigTxtStyle,
                    ),
                    Text(
                      "%",
                      style: TextStyle(color: AppThemes.weightNumberColor),
                    ),
                  ],
                ),
                Text(
                  "Finished",
                  style: AppThemes.weightNumberMediumTxtStyle,
                )
              ],
            )
          ],
        ));
  }
}
