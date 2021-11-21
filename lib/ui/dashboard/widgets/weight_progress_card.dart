import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:weighty/ui/dashboard/widgets/current_weight_widget.dart';
import 'package:weighty/ui/dashboard/widgets/target_weight_widget.dart';

class WeightProgressCard extends StatefulWidget {
  WeightProgressCard() : super();

  @override
  _WeightProgressCardState createState() => _WeightProgressCardState();
}

class _WeightProgressCardState extends State<WeightProgressCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      color: Theme.of(context).canvasColor,
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoaded) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 110,
                  child: CurrentWeightWidget(),
                ),
                Icon(Icons.stream, color: Colors.white),
                SizedBox(
                  height: 50,
                  width: 110,
                  child: TargetWeightWidget(),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
