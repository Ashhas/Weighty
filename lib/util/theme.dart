import 'package:flutter/material.dart';

class AppThemes {
  static const Color primaryColor = Color.fromRGBO(76, 179, 250, 1.0);
  static const Color secondaryColor = Color.fromRGBO(95, 122, 165, 1.0);
  static const Color contentColor = Color.fromRGBO(145, 171, 188, 1.0);
  static const Color lastColor = Color.fromRGBO(223, 229, 243, 1.0);
  static const Color currentWeightColor = Color.fromRGBO(76, 178, 250, 1.0);
  static const Color weightTextColor = Color.fromRGBO(147, 166, 180, 1.0);
  static const Color weightNumberColor = Color.fromRGBO(57, 88, 142, 1.0);
  static const Color backgroundColor = Color.fromRGBO(249, 248, 253, 1.0);

  static const TextStyle screenTitleTxtStyle = TextStyle(
    fontSize: 20,
    color: secondaryColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w500,
  );
  static const TextStyle screenLabelTxtStyle = TextStyle(
    fontSize: 12,
    color: contentColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w400,
  );
  static const TextStyle currentWeightTxtStyle = TextStyle(
    fontSize: 40,
    color: currentWeightColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w400,
  );
  static const TextStyle weightNumberBigTxtStyle = TextStyle(
    fontSize: 30,
    color: weightNumberColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w400,
  );
  static const TextStyle weightNumberMediumTxtStyle = TextStyle(
    fontSize: 13,
    color: weightTextColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w400,
  );

  static const TextStyle weightNumberBoldTxtStyle = TextStyle(
    fontSize: 25,
    color: weightNumberColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w700,
  );

  static const TextStyle smallBoldTxtStyle = TextStyle(
    fontSize: 12,
    color: weightTextColor,
    fontFamily: "ProximaNova",
    fontWeight: FontWeight.w700,
  );

  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: primaryColor,
      accentColor: secondaryColor,
      canvasColor: lastColor,
      backgroundColor: contentColor,
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
