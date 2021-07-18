import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weighty/ui/settings/widgets/settings_tile.dart';
import 'package:weighty/util/constants/variable_const.dart';

class AboutScreen extends StatefulWidget {
  final String appVersion;

  AboutScreen({@required this.appVersion});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
              leading: Icon(Icons.developer_board_outlined, color: Colors.grey),
              onPressed: (BuildContext context) {
                _launchURL();
              },
            ),
            Divider(height: 1, thickness: 1),
            SettingsTile(
              title: "Version",
              titleTextStyle: Theme.of(context).primaryTextTheme.headline4,
              subtitle: widget.appVersion,
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
      toolbarHeight: 180,
      backgroundColor: Theme.of(context).canvasColor,
      leading: Container(),
      flexibleSpace: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Theme.of(context).buttonColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 10),
                Text(
                  "About",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
            SizedBox(height: 15),
            Container(
              height: 70,
              width: 70,
              child: Center(
                child: Image(
                  image: AssetImage("assets/app_icon.png"),
                ),
              ),
            ),
            Text(
              "Weighty",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _launchURL() async {
    await canLaunch(githubUrl)
        ? await launch(githubUrl)
        : throw 'Could not launch ' + githubUrl;
  }
}
