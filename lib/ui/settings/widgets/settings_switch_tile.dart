import 'package:flutter/material.dart';

class SettingsSwitchTile extends StatelessWidget {
  final String title;
  final int titleMaxLines;
  final String subtitle;
  final int subtitleMaxLines;
  final Widget leading;
  final Widget trailing;
  final Function(bool value) onToggle;
  final bool switchValue;
  final bool enabled;
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final Color switchActiveColor;

  SettingsSwitchTile({
    Key key,
    this.title,
    this.titleMaxLines,
    this.subtitle,
    this.subtitleMaxLines,
    this.leading,
    this.enabled = true,
    this.trailing,
    this.onToggle,
    this.switchValue,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.switchActiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: leading,
      value: switchValue,
      activeColor: switchActiveColor,
      onChanged: enabled ? onToggle : null,
      title: Text(
        title,
        style: titleTextStyle,
        maxLines: titleMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: subtitleTextStyle,
              maxLines: subtitleMaxLines,
              overflow: TextOverflow.ellipsis,
            )
          : null,
    );
  }
}
