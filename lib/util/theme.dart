import 'package:flutter/material.dart';

class AppThemes {
  static const Color yellow = Color(0xFFFFBC0F);
  static const Color green = Color(0xFF004C01);

  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: green,
      accentColor: yellow,
      canvasColor: green,
      backgroundColor: Colors.white,
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      primaryColor: green,
      accentColor: yellow,
      canvasColor: green,
      backgroundColor: Colors.white,
    );
  }
}

extension LightThemeExt on ThemeData {
  Color get homeButtonLightColor {
    return Colors.lightBlue;
  }
}

extension DarkThemeExt on ThemeData {
  Color get homeButtonDarkColor {
    return Color(0xFF5F6368);
  }
}
