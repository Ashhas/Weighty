import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/settings/weight_unit/weight_unit_bloc.dart';
import 'package:weighty/util/constants/ui_const.dart';
import 'package:weighty/util/constants/variable_const.dart';

class WeightUnitScreen extends StatefulWidget {
  WeightUnitScreen();

  @override
  _WeightUnitScreenState createState() => _WeightUnitScreenState();
}

class _WeightUnitScreenState extends State<WeightUnitScreen> {
  @override
  void initState() {
    BlocProvider.of<WeightUnitBloc>(context).add(WeightUnitStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String groupValue;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(),
      body: BlocBuilder<WeightUnitBloc, WeightUnitState>(
        builder: (context, state) {
          if (state is WeightUnitsLoaded) {
            //Set Current Weight Unit
            groupValue = state.weightUnit;

            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  RadioListTile(
                    title: Text(
                      UiConst.metricWeightUnit,
                      style: Theme.of(context).primaryTextTheme.bodyText2,
                    ),
                    value: metricMeasurement,
                    groupValue: groupValue,
                    onChanged: (value) {
                      groupValue = value;
                      BlocProvider.of<WeightUnitBloc>(context)
                          .add(ChangeWeightUnit(weightUnit: groupValue));
                    },
                  ),
                  Divider(height: 1, thickness: 1),
                  RadioListTile(
                    title: Text(
                      UiConst.imperialWeightUnit,
                      style: Theme.of(context).primaryTextTheme.bodyText2,
                    ),
                    value: imperialMeasurement,
                    groupValue: groupValue,
                    onChanged: (value) {
                      groupValue = value;
                      BlocProvider.of<WeightUnitBloc>(context)
                          .add(ChangeWeightUnit(weightUnit: groupValue));
                    },
                  ),
                  Divider(height: 1, thickness: 1),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Theme.of(context).canvasColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Theme.of(context).cardColor),
        color: Colors.black,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        "Weight Units",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
