import 'package:flutter/material.dart';
import 'package:weighty/util/constants/color_const.dart';

class FontConst {
  static const BOLD = TextStyle(
    fontWeight: FontWeight.w800,
  );

  static const MEDIUM = TextStyle(
    fontWeight: FontWeight.w600,
  );

  static const REGULAR = TextStyle(
    fontWeight: FontWeight.w400,
  );

  //Numbers TextStyle
  static final numberSmallRegularTextBlack =
      MEDIUM.copyWith(fontSize: 15, color: ColorConst.lightCanvasColor);
  static final numberSmallRegularTextWhite =
      MEDIUM.copyWith(fontSize: 15, color: Colors.white);
  static final numberBigBoldTextWhite =
      BOLD.copyWith(fontSize: 25, color: Colors.white);
  static final numberMidBoldTextWhite =
      BOLD.copyWith(fontSize: 20, color: Colors.white);

  //Body TextStyle
  static final bodyBigTextBlack =
      REGULAR.copyWith(fontSize: 16, color: Colors.black);
  static final bodyBigTextWhite =
      REGULAR.copyWith(fontSize: 16, color: Colors.white);
  static final bodyTextBlack =
      REGULAR.copyWith(fontSize: 15, color: Colors.black);
  static final bodyTextWhite =
      REGULAR.copyWith(fontSize: 15, color: Colors.white);

  //TitleView TextStyle
  static final titleViewTextBlack =
      MEDIUM.copyWith(fontSize: 20, color: Colors.black);
  static final titleViewTextWhite =
      MEDIUM.copyWith(fontSize: 20, color: Colors.white);

  //WeightUnit TextStyle
  static final smallBoldTextGreyOpacity =
      BOLD.copyWith(fontSize: 15, color: Colors.grey.withOpacity(0.6));
  static final smallBoldTextWhiteOpacity =
      BOLD.copyWith(fontSize: 15, color: Colors.white.withOpacity(0.6));

  //SubTitle TextStyle
  static final subtitleBigTextBlack =
      MEDIUM.copyWith(fontSize: 15, color: Colors.black);
  static final subtitleBigTextWhite =
      MEDIUM.copyWith(fontSize: 15, color: Colors.white);
  static final subtitleSmallTextBlack =
      REGULAR.copyWith(fontSize: 13, color: Colors.black);
  static final subtitleSmallTextWhite =
      REGULAR.copyWith(fontSize: 13, color: Colors.white);
}
