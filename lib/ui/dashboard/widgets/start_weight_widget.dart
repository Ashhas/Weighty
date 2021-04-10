import 'package:weighty/util/strings.dart';
import 'package:weighty/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StartWeightWidget extends StatefulWidget {
  final String startWeightDate;
  final double startWeight;

  StartWeightWidget({this.startWeightDate, this.startWeight}) : super();

  @override
  _StartWeightWidgetState createState() => _StartWeightWidgetState();
}

class _StartWeightWidgetState extends State<StartWeightWidget> {
  String startWeightDateFormat;

  @override
  Widget build(BuildContext context) {
    if (widget.startWeightDate != null) {
      startWeightDateFormat = new DateFormat.yMMMd('en_US')
          .format(DateTime.parse(widget.startWeightDate));
    }

    return Column(
      children: [
        Text(
          GlobalStrings.weightStartedTitle,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          widget.startWeight.toString() ?? "",
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          startWeightDateFormat ?? "-",
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
