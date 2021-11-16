import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/settings/settings_bloc.dart';
import 'package:weighty/bloc/theme/theme_bloc.dart';
import 'package:weighty/ui/settings/widgets/settings_switch_tile.dart';
import 'package:weighty/util/constants/ui_const.dart';

class ThemeScreen extends StatefulWidget {
  ThemeScreen();

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  _darkThemeTile(),
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
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).cardColor,
        ),
        color: Colors.black,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        UiConst.themeScreenTitle,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _darkThemeTile() {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        bool turnOnDarkTheme;

        if (state is CurrentThemeState) {
          state.isDarkTheme == null
              ? turnOnDarkTheme = false
              : turnOnDarkTheme = state.isDarkTheme;

          return SettingsSwitchTile(
            title: UiConst.enableDarkThemeTileTitle,
            titleTextStyle: Theme.of(context).primaryTextTheme.bodyText2,
            switchValue: turnOnDarkTheme,
            switchActiveColor: Theme.of(context).highlightColor,
            onToggle: (bool value) {
              setState(() {
                BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(value));
                turnOnDarkTheme = value;
              });
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
