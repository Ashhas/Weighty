import 'package:flutter/material.dart';
import 'package:weighty/util/constants/ui_const.dart';

class WeightChartScreen extends StatefulWidget {
  const WeightChartScreen() : super();

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
                UiConst.weightChartTitle,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Container());
  }
}
