import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LatestWeightStatsWidget extends StatefulWidget {
  final Box dataBox;
  final double targetWeight;
  final double startWeight;

  LatestWeightStatsWidget({this.dataBox, this.targetWeight, this.startWeight})
      : super();

  @override
  _LatestWeightWidgetState createState() => _LatestWeightWidgetState();
}

class _LatestWeightWidgetState extends State<LatestWeightStatsWidget> {
  MeasurementModel measurement;
  double startWeight = 0;
  double targetWeight = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.dataBox != null) {
      measurement = widget.dataBox.values.last;
      if (widget.startWeight != null) {
        startWeight = widget.startWeight;
        targetWeight = widget.targetWeight;
      }
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
          shape: ContinuousRectangleBorder(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  children: [
                    Text(
                      "172.4",
                      style: AppThemes.weightNumberBoldTxtStyle,
                    ),
                    Text(
                      "MOVING AVG",
                      style: AppThemes.weightNumberMediumTxtStyle,
                    ),
                  ],
                ),
              ),
              Divider(),
              Column(
                children: [
                  Text(
                    "1.4",
                    style: AppThemes.weightNumberBoldTxtStyle,
                  ),
                  Text(
                    "AVG. WEEKLY LOSS",
                    style: AppThemes.weightNumberMediumTxtStyle,
                  ),
                ],
              ),
              Divider(),
              Column(
                children: [
                  Text(
                    measurement != null
                        ? ((targetWeight - measurement.weightEntry) * -1)
                            .toString()
                        : "-",
                    style: AppThemes.weightNumberBoldTxtStyle,
                  ),
                  Text(
                    "LEFT TO GO",
                    style: AppThemes.weightNumberMediumTxtStyle,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
