import 'package:flutter/material.dart';
import 'package:weighty/util/constants/color_const.dart';
import 'package:weighty/util/constants/font_const.dart';

class AppTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: ColorConst.lightPrimaryColor,
      accentColor: ColorConst.lightAccentColor,
      backgroundColor: ColorConst.lightBackgroundColor,
      canvasColor: ColorConst.lightCanvasColor,
      focusColor: ColorConst.lightBottomAppBar,
      shadowColor: ColorConst.lightShadowColor,
      primaryTextTheme: TextTheme(
        bodyText2: FontConst.REGULAR_DEFAULT_BLACK,
        bodyText1: FontConst.REGULAR_SMALL_BLACK,
        headline6: FontConst.REGULAR_LARGE_BLACK,
        headline5: FontConst.LARGE_TILE,
        headline4: FontConst.REGULAR_TILE_BLACK,
        headline3: FontConst.REGULAR_SMALL_BLACK,
        headline2: FontConst.LARGE_NAME_TITLE,
        headline1: FontConst.LARGE_TILE_WHITE,
        subtitle1: FontConst.REGULAR_SMALL_BLACK,
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      primaryColor: ColorConst.darkPrimaryColor,
      accentColor: ColorConst.darkAccentColor,
      backgroundColor: ColorConst.darkBackgroundColor,
      canvasColor: ColorConst.darkCanvasColor,
      focusColor: ColorConst.darkBottomAppBar,
      shadowColor: ColorConst.darkShadowColor,
      primaryTextTheme: TextTheme(
        bodyText2: FontConst.REGULAR_DEFAULT_WHITE,
        bodyText1: FontConst.REGULAR_SMALL_WHITE,
        headline6: FontConst.REGULAR_LARGE_WHITE,
        headline5: FontConst.LARGE_TILE,
        headline4: FontConst.REGULAR_TILE_WHITE,
        headline3: FontConst.REGULAR_SMALL_WHITE,
        headline2: FontConst.LARGE_NAME_TITLE,
        headline1: FontConst.LARGE_TILE_WHITE,
        subtitle1: FontConst.REGULAR_SMALL_WHITE,
      ),
    );
  }
}
