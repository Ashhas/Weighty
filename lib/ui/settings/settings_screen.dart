import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weighty/bloc/app_theme/theme_bloc.dart';
import 'package:weighty/util/shared_pref_service.dart';
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
    _initSettings();
    _getPrefsData();
  }

  Future _initSettings() async {
    textFormController = TextEditingController();
    themeSwitch = false;
  }

  Future _getPrefsData() async {
    sharedPrefService = await SharedPreferencesService.instance;

    setState(() {
      userName = sharedPrefService.getUsername;
      startWeight = sharedPrefService.getStartWeight;
      startWeightDate = sharedPrefService.getStartWeightDate;
      targetWeight = sharedPrefService.getTargetWeight;
      targetWeightDate = sharedPrefService.getTargetWeightDate;
      weightUnitType = sharedPrefService.getWeightUnitType;
      reminderStatus = sharedPrefService.getReminderStatus;
      themeSwitch = sharedPrefService.getThemeDarkMode;
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
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(GlobalStrings.settingsTitle,
            style: Theme.of(context).textTheme.headline4),
        centerTitle: true,
      ),
      body: SettingsList(
        backgroundColor: Theme.of(context).backgroundColor,
        sections: [
          SettingsSection(
            title: GlobalStrings.profileTileSection,
            titleTextStyle: Theme.of(context).textTheme.headline3,
            tiles: [
              SettingsTile(
                title: GlobalStrings.nameTile,
                titleTextStyle: Theme.of(context).textTheme.headline4,
                trailing: Text(userName ?? "",
                    style: Theme.of(context).textTheme.headline2),
                onPressed: (BuildContext context) {
                  _showNamePopup();
                },
              ),
              SettingsTile(
                title: GlobalStrings.StartWeightTile,
                titleTextStyle: Theme.of(context).textTheme.headline4,
                trailing: Text(
                    startWeight.toString() +
                            " on " +
                            startWeightDateFormat.toString() ??
                        "",
                    style: Theme.of(context).textTheme.headline2),
                onPressed: (BuildContext context) {
                  _showStartWeightPopup();
                },
              ),
              SettingsTile(
                title: GlobalStrings.targetWeightTile,
                titleTextStyle: Theme.of(context).textTheme.headline4,
                trailing: Text(
                    targetWeight.toString() +
                            " on " +
                            targetWeightDateFormat.toString() ??
                        "",
                    style: Theme.of(context).textTheme.headline2),
                onPressed: (BuildContext context) {
                  _showTargetWeightPopup();
                },
              ),
            ],
          ),
          SettingsSection(
            title: GlobalStrings.optionsTileSection,
            titleTextStyle: Theme.of(context).textTheme.headline3,
            tiles: [
              SettingsTile(
                title: GlobalStrings.unitTile,
                trailing: Text(weightUnitType ?? "",
                    style: Theme.of(context).textTheme.headline2),
                onPressed: (BuildContext context) {
                  _showUnitsPopup();
                },
              ),
              SettingsTile.switchTile(
                title: GlobalStrings.reminderTile,
                onToggle: null,
                switchValue: reminderStatus ?? false,
              ),
              SettingsTile.switchTile(
                title: GlobalStrings.themeTile,
                onToggle: (bool value) {
                  setState(() {
                    if (value) {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(ThemeChangedEvent(true));
                    } else {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(ThemeChangedEvent(false));
                    }
                    themeSwitch = value;
                  });
                },
                switchValue: themeSwitch,
              ),
            ],
          ),
          SettingsSection(
            title: GlobalStrings.manageDataTileSection,
            titleTextStyle: Theme.of(context).textTheme.headline3,
            tiles: [
              SettingsTile(
                title: GlobalStrings.exportTile,
                trailing: Icon(Icons.chevron_right),
              ),
              SettingsTile(
                title: GlobalStrings.deleteTile,
                trailing: Icon(Icons.chevron_right),
              ),
              SettingsTile(
                title: GlobalStrings.syncTile,
                trailing: Icon(Icons.chevron_right),
              )
            ],
          ),
          SettingsSection(
            title: GlobalStrings.moreDataTileSection,
            titleTextStyle: Theme.of(context).textTheme.headline3,
            tiles: [
              SettingsTile(
                title: GlobalStrings.helpFeedbackTile,
                trailing: Icon(Icons.chevron_right),
              ),
              SettingsTile(
                title: GlobalStrings.RatingTile,
                trailing: Icon(Icons.chevron_right),
              ),
              SettingsTile(
                title: GlobalStrings.devInfoTile,
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
                            style: Theme.of(context).textTheme.subtitle1,
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
                            color: Theme.of(context).primaryColor,
                            onPressed: () async {
                              setState(() {
                                sharedPrefService
                                    .setUsername(textFormController.text);
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
                    padding: EdgeInsets.only(right: 8.0, top: 8.0, left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "START WEIGHT",
                          style: Theme.of(context).textTheme.subtitle1,
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
                            color: Theme.of(context).primaryColor,
                            onPressed: () async {
                              sharedPrefService.setStartWeight(
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
                            style: Theme.of(context).textTheme.subtitle1,
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
                            color: Theme.of(context).primaryColor,
                            onPressed: () async {
                              sharedPrefService.setTargetWeight(
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
    String _dropDownValue;

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
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        new DropdownButton<String>(
                          hint: _dropDownValue == null
                              ? Text("Choose Unit")
                              : _dropDownValue,
                          isExpanded: true,
                          items: GlobalStrings.unitTypes.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _dropDownValue = value;
                            });
                          },
                        )
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
                            color: Theme.of(context).primaryColor,
                            onPressed: () async {
                              sharedPrefService
                                  .setWeightUnitType(_dropDownValue);

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
