import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:weighty/bloc/settings/settings_bloc.dart';
import 'package:weighty/ui/settings/screens/about_screen.dart';
import 'package:weighty/ui/settings/screens/goal_screen.dart';
import 'package:weighty/ui/settings/screens/help_and_faq_screen.dart';
import 'package:weighty/ui/settings/screens/manage_data_screen.dart';
import 'package:weighty/ui/settings/screens/reminder_screen.dart';
import 'package:weighty/ui/settings/screens/theme_screen.dart';
import 'package:weighty/util/constants/ui_const.dart';
import 'package:weighty/util/shared_pref_service.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController textFormController;
  SharedPreferencesService sharedPrefService;
  String userName;
  String userGender;
  int userAge;
  double userHeight;
  String weightUnitType;
  bool reminderStatus;
  bool themeSwitch;
  double startWeight;
  String startWeightDate;
  String startWeightDateFormat;
  double targetWeight;
  String targetWeightDate;
  String targetWeightDateFormat;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingsBloc>(context).add(SettingsStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGoalTile(),
                  Divider(height: 1, thickness: 1),
                  _buildThemeTile(),
                  _buildRemindersTile(),
                  Divider(height: 1, thickness: 1),
                  _buildAboutTile(state.appVersion),
                  _buildHelpAndFaqTile(),
                  SizedBox(height: 100),
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

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      title: Column(
        children: [
          Text(
            UiConst.settingsTitle,
            style: GoogleFonts.roboto(color: Colors.white),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  Widget _buildGoalTile() {
    return SettingsTile(
      title: "Goal Preferences",
      titleTextStyle: Theme.of(context).primaryTextTheme.headline4,
      leading: Icon(
        Icons.verified,
        color: Colors.grey,
      ),
      onPressed: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoalScreen()),
        );
      },
    );
  }

  Widget _buildRemindersTile() {
    return SettingsTile(
      title: "Reminders",
      titleTextStyle: Theme.of(context).primaryTextTheme.headline4,
      leading: Icon(
        Icons.notifications_active,
        color: Colors.grey,
      ),
      onPressed: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReminderScreen()),
        );
      },
      enabled: false,
    );
  }

  Widget _buildThemeTile() {
    return SettingsTile(
      title: "Theme",
      titleTextStyle: Theme.of(context).primaryTextTheme.headline4,
      leading: Icon(
        Icons.dark_mode,
        color: Colors.grey,
      ),
      onPressed: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ThemeScreen()),
        );
      },
    );
  }

  Widget _buildAboutTile(String appVersion) {
    return SettingsTile(
      title: "About",
      titleTextStyle: Theme.of(context).primaryTextTheme.headline4,
      leading: Icon(
        Icons.info_outline,
        color: Colors.grey,
      ),
      onPressed: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AboutScreen(appVersion: appVersion)),
        );
      },
    );
  }

  Widget _buildHelpAndFaqTile() {
    return SettingsTile(
      title: "Help/FAQ",
      titleTextStyle: Theme.of(context).primaryTextTheme.headline4,
      leading: Icon(
        Icons.help_outline,
        color: Colors.grey,
      ),
      onPressed: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HelpFaqScreen()),
        );
      },
    );
  }
}
