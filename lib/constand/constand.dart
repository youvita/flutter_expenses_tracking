import 'package:flutter/material.dart';

//Text Style
class MyTextStyles {
  static const TextStyle textStyle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: MyColors.white,
  );

  static const TextStyle textStyleBold20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: MyColors.black,
  );

  static const TextStyle textStyleNormal15 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: MyColors.black,
  );

  static const TextStyle textStyleMedium17 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: MyColors.black,
  );

  static const TextStyle textStyleBold17 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: MyColors.black,
  );

  static const TextStyle switchStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}



//Colors
class MyColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color blue = Color(0xFF3743EC);
  static const Color green = Color(0xFF38AD52);
  static const Color red = Color(0xFFFF0000);
  static const Color black = Color(0xFF000000);
  static const Color black10 = Color(0x1A0A0A0A);
}