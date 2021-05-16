import 'package:flutter/material.dart';

class AppThemes {
  static const Color _lightPrimaryColor = Color(0xFF3F49D0);
  static const Color _lightSecondaryColor = Colors.blueAccent;
  static const Color _lightContentColor = Color(0xFFFFFFFF);
  static const Color _lightBackgroundColor = Color(0xFFF8F8F8);
  static const Color _lightPrimaryTextColor = Color(0xFF1B2542);
  static const Color _lightSecondaryTextColor = Color(0xFFA0AEC5);

  static const Color _darkPrimaryColor = Colors.blueAccent;
  static const Color _darkSecondaryColor = Color(0xFFF8AE6B);
  static const Color _darkContentColor = Color(0xFF262a34);
  static const Color _darkCardColor = Color(0xFF262a34);
  static const Color _darkBackgroundColor = Color(0xFF191b21);
  static const Color _darkPrimaryTextColor = Color(0xFFFFFFFF);
  static const Color _darkSecondaryTextColor = Color(0xFFC7BFFF);

  static ThemeData getLightTheme() {
    return ThemeData(
        primaryColor: _lightPrimaryColor,
        accentColor: _lightSecondaryColor,
        canvasColor: _lightContentColor,
        backgroundColor: _lightBackgroundColor,
        focusColor: Colors.blue,
        shadowColor: _lightPrimaryTextColor,
        textTheme: TextTheme(
          ///ScreenTitle TxtStyle
          headline6: TextStyle(
            fontSize: 20,
            color: _lightPrimaryTextColor,
            fontWeight: FontWeight.w500,
          ),

          ///ScreenTitle(label) TxtStyle
          headline5: TextStyle(
            fontSize: 12,
            color: _lightPrimaryTextColor,
            fontWeight: FontWeight.w400,
          ),

          ///Settings tile TxtStyle
          headline4: TextStyle(
            fontSize: 16,
            color: _lightPrimaryTextColor,
            fontWeight: FontWeight.w500,
          ),

          ///Settings tile-group TxtStyle
          headline3: TextStyle(
            fontSize: 16,
            color: _darkSecondaryTextColor,
            fontWeight: FontWeight.w400,
          ),

          ///Settings tile-content TxtStyle
          headline2: TextStyle(
            fontSize: 14,
            color: _lightPrimaryTextColor,
            fontWeight: FontWeight.w500,
          ),

          ///WeightNumbers TxtStyle
          headline1: TextStyle(
            fontSize: 40,
            color: _lightPrimaryTextColor,
            fontWeight: FontWeight.w400,
          ),

          ///Big Numbers TxtStyle
          bodyText1: TextStyle(
            fontSize: 30,
            color: _lightPrimaryTextColor,
            fontWeight: FontWeight.w400,
          ),

          ///Small Numbers TxtStyle
          bodyText2: TextStyle(
            fontSize: 13,
            color: _lightSecondaryTextColor,
            fontWeight: FontWeight.w400,
          ),

          ///Small Bold TxtStyle
          subtitle1: TextStyle(
            fontSize: 12,
            color: _lightPrimaryTextColor,
            fontWeight: FontWeight.w700,
          ),

          ///Medium Bold TxtStyle
          subtitle2: TextStyle(
            fontSize: 25,
            color: _lightPrimaryTextColor,
            fontWeight: FontWeight.w700,
          ),
        ));
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
        primaryColor: _darkPrimaryColor,
        accentColor: _darkSecondaryColor,
        canvasColor: _darkBackgroundColor,
        backgroundColor: _darkBackgroundColor,
        focusColor: Colors.blue,
        shadowColor: _darkPrimaryTextColor,
        cardColor: _darkCardColor,
        highlightColor: Colors.white,
        textTheme: TextTheme(
          ///ScreenTitle TxtStyle
          headline6: TextStyle(
            fontSize: 20,
            color: _darkPrimaryTextColor,
            fontWeight: FontWeight.w500,
          ),

          ///ScreenTitle(label) TxtStyle
          headline5: TextStyle(
            fontSize: 12,
            color: _darkPrimaryTextColor,
            fontWeight: FontWeight.w400,
          ),

          ///Settings tile TxtStyle
          headline4: TextStyle(
            fontSize: 16,
            color: _darkPrimaryTextColor,
            fontWeight: FontWeight.w500,
          ),

          ///Settings tile-group TxtStyle
          headline3: TextStyle(
            fontSize: 16,
            color: _darkSecondaryTextColor,
            fontWeight: FontWeight.w400,
          ),

          ///Settings tile-content TxtStyle
          headline2: TextStyle(
            fontSize: 14,
            color: _darkPrimaryTextColor,
            fontWeight: FontWeight.w500,
          ),

          ///WeightNumbers TxtStyle
          headline1: TextStyle(
            fontSize: 40,
            color: _darkPrimaryTextColor,
            fontWeight: FontWeight.w400,
          ),

          ///Big Numbers TxtStyle
          bodyText1: TextStyle(
            fontSize: 30,
            color: _darkPrimaryTextColor,
            fontWeight: FontWeight.w400,
          ),

          ///Small Numbers TxtStyle
          bodyText2: TextStyle(
            fontSize: 13,
            color: _darkSecondaryTextColor,
            fontWeight: FontWeight.w400,
          ),

          ///Small Bold TxtStyle
          subtitle1: TextStyle(
            fontSize: 12,
            color: _darkPrimaryTextColor,
            fontWeight: FontWeight.w700,
          ),

          ///Medium Bold TxtStyle
          subtitle2: TextStyle(
            fontSize: 25,
            color: _darkPrimaryTextColor,
            fontWeight: FontWeight.w700,
          ),
        ));
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
