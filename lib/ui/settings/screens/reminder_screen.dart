import 'package:flutter/material.dart';
import 'package:weighty/util/constants/ui_const.dart';

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
        child: Text(
          UiConst.remindersScreenTitle,
        ),
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
        UiConst.remindersScreenTitle,
        style: Theme.of(context).primaryTextTheme.headline4,
      ),
    );
  }
}
