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
      cardColor: ColorConst.lightBackgroundColor,
      highlightColor: ColorConst.lightPrimaryColor,
      backgroundColor: ColorConst.lightBackgroundColor,
      bottomAppBarColor: ColorConst.lightBottomAppBar,
      hintColor: Colors.grey,
      primaryTextTheme: TextTheme(
        headline1: FontConst.numberBigBoldTextWhite,
        headline2: FontConst.numberMidBoldTextWhite,
        headline3: FontConst.titleViewTextBlack,
        headline4: FontConst.smallBoldTextGreyOpacity,
        headline5: FontConst.numberSmallRegularTextBlack,
        subtitle1: FontConst.subtitleBigTextWhite,
        subtitle2: FontConst.subtitleSmallTextBlack,
        bodyText1: FontConst.bodyTextBlack,
        bodyText2: FontConst.bodyBigTextBlack,
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
      cardColor: ColorConst.darkBackgroundColor,
      highlightColor: ColorConst.darkPrimaryColor,
      backgroundColor: ColorConst.darkBackgroundColor,
      bottomAppBarColor: ColorConst.darkBottomAppBar,
      hintColor: Colors.grey,
      primaryTextTheme: TextTheme(
        headline1: FontConst.numberBigBoldTextWhite,
        headline2: FontConst.numberMidBoldTextWhite,
        headline3: FontConst.titleViewTextWhite,
        headline4: FontConst.smallBoldTextWhiteOpacity,
        headline5: FontConst.numberSmallRegularTextWhite,
        subtitle1: FontConst.subtitleBigTextWhite,
        subtitle2: FontConst.subtitleSmallTextWhite,
        bodyText1: FontConst.bodyTextWhite,
        bodyText2: FontConst.bodyBigTextWhite,
      ),
    );
  }
}
