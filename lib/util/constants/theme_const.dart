import 'package:flutter/material.dart';
import 'package:weighty/util/constants/color_const.dart';
import 'package:weighty/util/constants/font_const.dart';

class AppTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: ColorConst.lightPrimaryColor,
      accentColor: ColorConst.lightAccentColor,
      focusColor: ColorConst.lightFocusColor,
      shadowColor: ColorConst.lightShadowColor,
      canvasColor: ColorConst.lightCanvasColor,
      backgroundColor: ColorConst.lightBackgroundColor,
      bottomAppBarColor: ColorConst.lightBottomAppBar,
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
        subtitle2: FontConst.REGULAR_SMALL_ERROR,
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      primaryColor: ColorConst.darkPrimaryColor,
      accentColor: ColorConst.darkAccentColor,
      focusColor: ColorConst.darkFocusColor,
      shadowColor: ColorConst.darkShadowColor,
      canvasColor: ColorConst.darkCanvasColor,
      backgroundColor: ColorConst.darkBackgroundColor,
      bottomAppBarColor: ColorConst.darkBottomAppBar,
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
        subtitle2: FontConst.REGULAR_SMALL_ERROR,
      ),
    );
  }
}
