import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/settings/goals/goals_bloc.dart';
import 'package:weighty/ui/settings/widgets/edit_start_weight_dialog.dart';
import 'package:weighty/ui/settings/widgets/edit_target_weight_dialog.dart';
import 'package:weighty/ui/settings/widgets/settings_tile.dart';

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
        appBar: _buildAppBar(),
        body: BlocBuilder<GoalsBloc, GoalsState>(
          builder: (context, state) {
            if (state is GoalsLoaded) {
              return Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SettingsTile(
                      title: "Start Weight",
                      titleTextStyle:
                          Theme.of(context).primaryTextTheme.headline4,
                      subtitleTextStyle:
                          Theme.of(context).primaryTextTheme.subtitle1,
                      trailing: Text(state.startWeight.toString(),
                          style: Theme.of(context).primaryTextTheme.subtitle1),
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
                      title: "Current Weight",
                      titleTextStyle:
                          Theme.of(context).primaryTextTheme.headline4,
                      subtitleTextStyle:
                          Theme.of(context).primaryTextTheme.subtitle1,
                      trailing: Text(state.currentWeight.toString(),
                          style: Theme.of(context).primaryTextTheme.subtitle1),
                      onPressed: (BuildContext context) {},
                    ),
                    Divider(height: 1, thickness: 1),
                    SettingsTile(
                      title: "Goal Weight",
                      titleTextStyle:
                          Theme.of(context).primaryTextTheme.headline4,
                      subtitleTextStyle:
                          Theme.of(context).primaryTextTheme.subtitle1,
                      trailing: Text(state.targetWeight.toString(),
                          style: Theme.of(context).primaryTextTheme.subtitle1),
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
        ));
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Theme.of(context).canvasColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Theme.of(context).buttonColor),
        color: Colors.black,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        "Goal Preferences",
        style: Theme.of(context).primaryTextTheme.headline4,
      ),
    );
  }
}
