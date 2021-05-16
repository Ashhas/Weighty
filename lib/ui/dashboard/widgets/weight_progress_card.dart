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
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStartWeightWidget(),
              _buildCurrentWeightWidget(),
              _buildTargetWeightWidget(),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildCurrentWeightWidget() {
    return CurrentWeightWidget();
  }

  Widget _buildTargetWeightWidget() {
    return TargetWeightWidget();
  }

  Widget _buildStartWeightWidget() {
    return StartWeightWidget();
  }
}
