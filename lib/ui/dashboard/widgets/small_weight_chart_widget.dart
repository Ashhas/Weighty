import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SmallWeightChartWidget extends StatefulWidget {
  final Box dataBox;

  SmallWeightChartWidget({this.dataBox}) : super();

  @override
  _SmallWeightChartWidgetState createState() => _SmallWeightChartWidgetState();
}

class _SmallWeightChartWidgetState extends State<SmallWeightChartWidget> {
  MeasurementModel measurement;
  double startWeight = 0;
  double targetWeight = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.dataBox != null) {
      measurement = widget.dataBox.values.last;
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Column(
          children: [
            Container(
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Weight",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Text("169"),
                ],
              ),
            ),
            Container(
              height: 100,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
