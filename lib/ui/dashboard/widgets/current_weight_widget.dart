import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../../../util/strings.dart';

class CurrentWeightWidget extends StatefulWidget {
  final Box dataBox;
  final double targetWeight;
  final double startWeight;

  CurrentWeightWidget({this.dataBox, this.targetWeight, this.startWeight})
      : super();

  @override
  _CurrentWeightWidgetState createState() => _CurrentWeightWidgetState();
}

class _CurrentWeightWidgetState extends State<CurrentWeightWidget> {
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

    return Column(
      children: [
        Text(
          GlobalStrings.weightCurrentTitle,
          style: AppThemes.weightNumberMediumTxtStyle,
        ),
        Text(
          measurement != null ? measurement.weightEntry.toString() : "-",
          style: AppThemes.weightNumberBigTxtStyle,
        ),
        Text(
          measurement != null
              ? new DateFormat.yMMMd('en_US').format(measurement.dateAdded)
              : "-",
          style: AppThemes.weightNumberMediumTxtStyle,
        ),
      ],
    );
  }
}
