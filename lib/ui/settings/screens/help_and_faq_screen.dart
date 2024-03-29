import 'package:flutter/material.dart';
import 'package:weighty/util/constants/ui_const.dart';

class HelpFaqScreen extends StatefulWidget {
  HelpFaqScreen();

  @override
  _HelpFaqScreenState createState() => _HelpFaqScreenState();
}

class _HelpFaqScreenState extends State<HelpFaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(),
      body: Container(
        width: double.infinity,
        child: Center(
          child: Text(
            UiConst.helpFaqScreenTitle,
          ),
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
        UiConst.helpFaqScreenTitle,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
