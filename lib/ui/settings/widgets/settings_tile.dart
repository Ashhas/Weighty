import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final int titleMaxLines;
  final String subtitle;
  final int subtitleMaxLines;
  final Widget leading;
  final Widget trailing;
  final VoidCallback onTap;
  final Function(BuildContext context) onPressed;
  final bool enabled;
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final Color switchActiveColor;

  SettingsTile({
    Key key,
    this.title,
    this.titleMaxLines,
    this.subtitle,
    this.subtitleMaxLines,
    this.leading,
    this.trailing,
    @Deprecated('Use onPressed instead') this.onTap,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.enabled = true,
    this.onPressed,
    this.switchActiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: titleTextStyle),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: subtitleTextStyle,
              maxLines: subtitleMaxLines,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      leading: leading,
      enabled: enabled,
      trailing: trailing,
      onTap: onTapFunction(context) as void Function(),
    );
  }

  Function onTapFunction(BuildContext context) =>
      onTap != null || onPressed != null
          ? () {
              if (onPressed != null) {
                onPressed.call(context);
              } else {
                onTap.call();
              }
            }
          : null;
}
