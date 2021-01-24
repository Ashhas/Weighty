import 'package:weighty/util/strings.dart';
import 'package:weighty/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TargetWeightWidget extends StatefulWidget {
  final String targetWeightDate;
  final double targetWeight;

  TargetWeightWidget({this.targetWeightDate, this.targetWeight}) : super();

  @override
  _TargetWeightWidgetState createState() => _TargetWeightWidgetState();
}

class _TargetWeightWidgetState extends State<TargetWeightWidget> {
  String startWeightDateFormat;

  @override
  Widget build(BuildContext context) {
    if (widget.targetWeightDate != null) {
      startWeightDateFormat = new DateFormat.yMMMd('en_US')
          .format(DateTime.parse(widget.targetWeightDate));
    }

    return Column(
      children: [
        Text(
          GlobalStrings.weightTargetTitle,
          style: AppThemes.weightNumberMediumTxtStyle,
        ),
        Text(
          widget.targetWeight.toString() ?? "",
          style: AppThemes.weightNumberBigTxtStyle,
        ),
        Text(
          startWeightDateFormat ?? "-",
          style: AppThemes.weightNumberMediumTxtStyle,
        ),
      ],
    );
  }
}
