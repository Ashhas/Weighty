import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weighty/ui/settings/widgets/settings_tile.dart';
import 'package:weighty/util/constants/ui_const.dart';
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
              title: UiConst.githubTileTitle,
              titleTextStyle: Theme.of(context).primaryTextTheme.bodyText2,
              leading: Icon(Icons.developer_board_outlined, color: Colors.grey),
              onPressed: (BuildContext context) {
                _launchURL();
              },
            ),
            Divider(height: 1, thickness: 1),
            SettingsTile(
              title: UiConst.versionTileTitle,
              titleTextStyle: Theme.of(context).primaryTextTheme.bodyText2,
              subtitle: widget.appVersion,
              subtitleTextStyle: Theme.of(context).primaryTextTheme.subtitle2,
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
                  UiConst.aboutScreenTitle,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
            SizedBox(height: 15),
            Container(
              height: 80,
              width: 220,
              child: Center(
                child: Image(
                  image: AssetImage("assets/weighty_logo_name_white.png"),
                ),
              ),
            ),
            Text(
              UiConst.developerCreditTitle,
              style: Theme.of(context).primaryTextTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _launchURL() async {
    await canLaunch(githubUrl)
        ? await launch(githubUrl)
        : throw UiConst.githubUrlErrorMessage + githubUrl;
  }
}
