import 'package:flutter/material.dart';
import 'package:weighty/ui/common/common_app_bar.dart';
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
      appBar: CommonAppBar(appBarTitle: UiConst.helpFaqScreenTitle),
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
}
