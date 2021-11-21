import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/settings/goals/goals_bloc.dart';
import 'package:weighty/ui/common/common_app_bar.dart';
import 'package:weighty/ui/settings/widgets/edit_start_weight_dialog.dart';
import 'package:weighty/ui/settings/widgets/edit_target_weight_dialog.dart';
import 'package:weighty/ui/settings/widgets/settings_tile.dart';
import 'package:weighty/util/constants/ui_const.dart';

class GoalScreen extends StatefulWidget {
  GoalScreen();

  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  @override
  void initState() {
    BlocProvider.of<GoalsBloc>(context).add(GoalsStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CommonAppBar(appBarTitle: UiConst.goalPrefScreenTitle),
      body: BlocBuilder<GoalsBloc, GoalsState>(
        builder: (context, state) {
          if (state is GoalsLoaded) {
            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  SettingsTile(
                    title: UiConst.startWeightTileTitle,
                    titleTextStyle:
                        Theme.of(context).primaryTextTheme.bodyText2,
                    trailing: Text(state.startWeight.toString(),
                        style: Theme.of(context).primaryTextTheme.bodyText2),
                    onPressed: (BuildContext context) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EditStartWeightDialog(
                            startWeight: state.startWeight,
                          );
                        },
                      );
                    },
                  ),
                  Divider(height: 1, thickness: 1),
                  SettingsTile(
                    title: UiConst.goalWeightTileTitle,
                    titleTextStyle:
                        Theme.of(context).primaryTextTheme.bodyText2,
                    trailing: Text(state.targetWeight.toString(),
                        style: Theme.of(context).primaryTextTheme.bodyText2),
                    onPressed: (BuildContext context) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EditTargetWeightDialog(
                            targetWeight: state.targetWeight,
                          );
                        },
                      );
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
}
