import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weighty/util/strings.dart';
import 'package:weighty/util/theme.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController textFormController;
  SharedPreferences prefs;
  String userName;
  String userGender;
  int userAge;
  double userHeight;
  String weightUnitType;
  bool reminderStatus;
  double startWeight;
  String startWeightDate;
  String startWeightDateFormat;
  double targetWeight;
  String targetWeightDate;
  String targetWeightDateFormat;

  @override
  void initState() {
    super.initState();
    _initSettings();
    _getPrefsData();
  }

  Future _initSettings() async {
    textFormController = TextEditingController();
  }

  Future _getPrefsData() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString(GlobalStrings.userName);
      userGender = prefs.getString(GlobalStrings.userGender);
      userAge = prefs.getInt(GlobalStrings.userAge);
      userHeight = prefs.getDouble(GlobalStrings.userHeight);
      weightUnitType = prefs.getString(GlobalStrings.weightUnitType);
      reminderStatus = prefs.getBool(GlobalStrings.reminderStatus);
      startWeightDate = prefs.getString(GlobalStrings.userStartWeightDate);
      startWeight = prefs.getDouble(GlobalStrings.userStartWeight);
      targetWeightDate = prefs.getString(GlobalStrings.userTargetWeightDate);
      targetWeight = prefs.getDouble(GlobalStrings.userTargetWeight);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (startWeightDate != null) {
      startWeightDateFormat =
          new DateFormat.yMMMd('en_US').format(DateTime.parse(startWeightDate));
    }
    if (targetWeightDate != null) {
      targetWeightDateFormat = new DateFormat.yMMMd('en_US')
          .format(DateTime.parse(targetWeightDate));
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppThemes.backgroundColor,
        title: Text(
          GlobalStrings.settingsTitle,
          style: AppThemes.screenTitleTxtStyle,
        ),
        centerTitle: true,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Profile',
            tiles: [
              SettingsTile(
                title: 'Name',
                trailing: Text(userName ?? ""),
                onPressed: (BuildContext context) {
                  _showNamePopup();
                },
              ),
              SettingsTile(
                title: 'Age',
                trailing: Text(userAge.toString() ?? ""),
                onPressed: (BuildContext context) {
                  _showAgePopup();
                },
              ),
              SettingsTile(
                title: 'Height',
                trailing: Text(userHeight.toString() ?? ""),
                onPressed: (BuildContext context) {
                  _showHeightPopup();
                },
              ),
              SettingsTile(
                title: 'Start Weight',
                trailing: Text(
                  startWeight.toString() +
                          " on " +
                          startWeightDateFormat.toString() ??
                      "",
                ),
                onPressed: (BuildContext context) {
                  _showStartWeightPopup();
                },
              ),
              SettingsTile(
                title: 'Target Weight',
                trailing: Text(
                  targetWeight.toString() +
                          " on " +
                          targetWeightDateFormat.toString() ??
                      "",
                ),
                onPressed: (BuildContext context) {
                  _showTargetWeightPopup();
                },
              ),
            ],
          ),
          SettingsSection(
            title: "Options",
            tiles: [
              SettingsTile(
                title: "Units",
                trailing: Text(weightUnitType ?? ""),
                onPressed: (BuildContext context) {
                  _showUnitsPopup();
                },
              ),
              SettingsTile.switchTile(
                title: "Reminder",
                onToggle: null,
                switchValue: reminderStatus ?? false,
              ),
            ],
          ),
          SettingsSection(
            title: "Manage Data",
            tiles: [
              SettingsTile(
                title: "Export",
                trailing: Icon(Icons.chevron_right),
              ),
              SettingsTile(
                title: "Delete All",
                trailing: Icon(Icons.chevron_right),
              ),
              SettingsTile(
                title: "Sync",
                trailing: Icon(Icons.chevron_right),
              )
            ],
          ),
          SettingsSection(
            title: "More",
            tiles: [
              SettingsTile(
                title: "Help & Feedback",
                trailing: Icon(Icons.chevron_right),
              ),
              SettingsTile(
                title: "Rate App",
                trailing: Icon(Icons.chevron_right),
              ),
              SettingsTile(
                title: "More Apps",
                trailing: Icon(Icons.chevron_right),
              )
            ],
          )
        ],
      ),
    );
  }

  void _showNamePopup() {
    print('CALLBACK: _openEventPopup');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "NAME",
                            style: AppThemes.smallBoldTxtStyle,
                          ),
                        ),
                        TextFormField(
                          controller: textFormController,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            color: AppThemes.currentWeightColor,
                            onPressed: () async {
                              setState(() {
                                prefs.setString(GlobalStrings.userName,
                                    textFormController.text);
                              });
                              //Close Dialog
                              Navigator.of(context).pop();
                            },
                          ),
                          RaisedButton(
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              //Close Dialog
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  void _showAgePopup() {
    print('CALLBACK: _openEventPopup');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 100,
            title: new Text("Pick a new price"),
            initialIntegerValue: 10,
          );
        }).then((value) async {
      if (value != null) {
        //setState
        setState(() {
          prefs.setInt(GlobalStrings.userAge, value);
        });
      }
    });
  }

  void _showHeightPopup() {
    print('CALLBACK: _openEventPopup');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "HEIGHT",
                            style: AppThemes.smallBoldTxtStyle,
                          ),
                        ),
                        TextFormField(
                          controller: textFormController,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            color: AppThemes.currentWeightColor,
                            onPressed: () async {
                              await prefs.setDouble(GlobalStrings.userHeight,
                                  double.parse(textFormController.text));

                              //Close Dialog
                              Navigator.of(context).pop();
                            },
                          ),
                          RaisedButton(
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              //Close Dialog
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  void _showStartWeightPopup() {
    print('CALLBACK: _openEventPopup');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "START WEIGHT",
                            style: AppThemes.smallBoldTxtStyle,
                          ),
                        ),
                        TextFormField(
                          controller: textFormController,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            color: AppThemes.currentWeightColor,
                            onPressed: () async {
                              await prefs.setDouble(
                                  GlobalStrings.userStartWeight,
                                  double.parse(textFormController.text));

                              //Close Dialog
                              Navigator.of(context).pop();
                            },
                          ),
                          RaisedButton(
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              //Close Dialog
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  void _showTargetWeightPopup() {
    print('CALLBACK: _openEventPopup');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "TARGET WEIGHT",
                            style: AppThemes.smallBoldTxtStyle,
                          ),
                        ),
                        TextFormField(
                          controller: textFormController,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            color: AppThemes.currentWeightColor,
                            onPressed: () async {
                              await prefs.setDouble(
                                  GlobalStrings.userTargetWeight,
                                  double.parse(textFormController.text));

                              //Close Dialog
                              Navigator.of(context).pop();
                            },
                          ),
                          RaisedButton(
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              //Close Dialog
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  void _showUnitsPopup() {
    print('CALLBACK: _openEventPopup');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "UNIT",
                            style: AppThemes.smallBoldTxtStyle,
                          ),
                        ),
                        TextFormField(
                          controller: textFormController,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            color: AppThemes.currentWeightColor,
                            onPressed: () async {
                              await prefs.setString(
                                  GlobalStrings.weightUnitType,
                                  textFormController.text);

                              //Close Dialog
                              Navigator.of(context).pop();
                            },
                          ),
                          RaisedButton(
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              //Close Dialog
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }
}
