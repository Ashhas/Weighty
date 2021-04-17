import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:weighty/ui/dashboard/widgets/latest_weight_date_widget.dart';
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
            child: Padding(
              padding: EdgeInsets.only(top: 15, left: 25, right: 25),
              child: Column(
                children: [
                  _buildCardTitle(state.percentageDone),
                  SizedBox(height: 15),
                  _buildCurrentWeightRow(),
                  Divider(),
                  _buildWeightProgressRow(),
                  SizedBox(height: 20),
                  _buildProgressBar(state.percentageDone),
                  SizedBox(height: 20),
                ],
              ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Weight Measurements",
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  Widget _buildCurrentWeightRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CurrentWeightWidget(),
        LatestWeightWidget(),
      ],
    );
  }

  Widget _buildWeightProgressRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StartWeightWidget(),
        TargetWeightWidget(),
      ],
    );
  }

  Widget _buildProgressBar(double percentageDone) {
    return LinearProgressIndicator(
      value: percentageDone / 100,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      backgroundColor: Colors.grey,
    );
  }
}
