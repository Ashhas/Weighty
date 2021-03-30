import 'package:flutter/material.dart';

class AppThemes {
  static const Color lightPrimaryColor = Color(0xFF6A55F8);
  static const Color lightSecondaryColor = Color(0xFFF8AE6B);
  static const Color lightContentColor = Color(0xFFFFFFFF);
  static const Color lightBackgroundColor = Color(0xFFF4F4F8);
  static const Color lightPrimaryTextColor = Color(0xFF1B2542);
  static const Color lightSecondaryTextColor = Color(0xFF1B2542);

  static const Color darkPrimaryColor = Color(0xFF6A55F8);
  static const Color darkSecondaryColor = Color(0xFFF8AE6B);
  static const Color darkContentColor = Color(0xFF39405F);
  static const Color darkBackgroundColor = Color(0xFF39405F);
  static const Color darkPrimaryTextColor = Color(0xFFFFFFFF);
  static const Color darkSecondaryTextColor = Color(0xFFC7BFFF);

  static const TextStyle screenTitleTxtStyle = TextStyle(
    fontSize: 20,
    color: lightPrimaryTextColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w500,
  );
  static const TextStyle screenLabelTxtStyle = TextStyle(
    fontSize: 12,
    color: lightPrimaryTextColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w400,
  );
  static const TextStyle currentWeightTxtStyle = TextStyle(
    fontSize: 40,
    color: lightPrimaryTextColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w400,
  );
  static const TextStyle weightNumberBigTxtStyle = TextStyle(
    fontSize: 30,
    color: lightPrimaryTextColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w400,
  );
  static const TextStyle weightNumberMediumTxtStyle = TextStyle(
    fontSize: 13,
    color: lightSecondaryTextColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w400,
  );

  static const TextStyle weightNumberBoldTxtStyle = TextStyle(
    fontSize: 25,
    color: lightPrimaryTextColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w700,
  );

  static const TextStyle smallBoldTxtStyle = TextStyle(
    fontSize: 12,
    color: lightPrimaryTextColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w700,
  );
  static const TextStyle settingsTileTxtStyle = TextStyle(
    fontSize: 16,
    color: lightPrimaryTextColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w500,
  );
  static const TextStyle settingsTileContentTxtStyle = TextStyle(
    fontSize: 14,
    color: lightPrimaryTextColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w500,
  );
  static const TextStyle settingsTileGroupTitleTxtStyle = TextStyle(
    fontSize: 16,
    color: darkSecondaryTextColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w400,
  );

  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: lightPrimaryColor,
      accentColor: lightSecondaryColor,
      canvasColor: lightBackgroundColor,
      backgroundColor: lightContentColor,
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      primaryColor: darkPrimaryColor,
      accentColor: darkSecondaryColor,
      canvasColor: darkBackgroundColor,
      backgroundColor: darkContentColor,
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
