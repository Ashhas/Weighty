import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weighty/ui/settings/widgets/settings_tile.dart';
import 'package:weighty/util/constants/variable_const.dart';

class ReminderScreen extends StatefulWidget {
  ReminderScreen();

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SettingsTile(
              title: "Github",
              titleTextStyle: Theme.of(context).primaryTextTheme.headline4,
              leading: Icon(Icons.developer_board_outlined,
                  color: Theme.of(context).buttonColor),
              onPressed: (BuildContext context) {
                _launchURL();
              },
            ),
            Divider(height: 1, thickness: 1),
            SettingsTile(
              title: "Version",
              titleTextStyle: Theme.of(context).primaryTextTheme.headline4,
              subtitleTextStyle: Theme.of(context).primaryTextTheme.subtitle1,
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: "Open-source licenses",
              titleTextStyle: Theme.of(context).primaryTextTheme.headline4,
              onPressed: (BuildContext context) {},
            ),
          ],
        ),
      ),
    );
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
        "Reminders",
        style: Theme.of(context).primaryTextTheme.headline4,
      ),
    );
  }

  void _launchURL() async {
    await canLaunch(VariableConst.githubUrl)
        ? await launch(VariableConst.githubUrl)
        : throw 'Could not launch ' + VariableConst.githubUrl;
  }
}
