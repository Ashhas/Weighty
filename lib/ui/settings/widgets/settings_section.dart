import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final String sectionTitle;

  const SettingsSection({Key key, this.sectionTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 6.0,
      ),
      child: Text(
        sectionTitle,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
