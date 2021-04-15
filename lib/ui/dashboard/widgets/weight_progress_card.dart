import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'current_weight_widget.dart';
import 'start_weight_widget.dart';
import 'target_weight_widget.dart';

class WeightProgressCard extends StatefulWidget {
  WeightProgressCard() : super();

  @override
  _WeightProgressCardState createState() => _WeightProgressCardState();
}

class _WeightProgressCardState extends State<WeightProgressCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoaded) {
          return Card(
            child: Column(
              children: [
                _buildCardTitle(state.percentageDone),
                SizedBox(height: 30),
                _buildWeightProgressRow(),
                SizedBox(height: 20),
                _buildProgressBar(state.percentageDone),
                SizedBox(height: 20),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildCardTitle(double percentageDone) {
    return Column(
      children: [
        Text(
          "Weight Loss Progress",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              percentageDone.toInt().toString(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              "% Completed",
              style: TextStyle(color: Theme.of(context).shadowColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeightProgressRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StartWeightWidget(),
        CurrentWeightWidget(),
        TargetWeightWidget(),
      ],
    );
  }

  Widget _buildProgressBar(double percentageDone) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: LinearProgressIndicator(
        value: percentageDone / 100,
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
