import 'package:flutter/material.dart';

//Text Style
class MyTextStyles {
  static const TextStyle textStyle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: MyColors.white,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: MyColors.white,
  );

    static const TextStyle appBarTitleWhite = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: MyColors.black,
  );

  static const TextStyle textStyleBold20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: MyColors.black,
  );

  static const TextStyle textStyleBold20Red = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: MyColors.red,
  );

  static const TextStyle textStyleBold20Green = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: MyColors.green,
  );

  static const TextStyle textStyle26 = TextStyle(
    fontSize: 26,
    color: MyColors.black,
  );

  static const TextStyle textStyleBold26Blue = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: MyColors.blue,
  );

  static const TextStyle textStyleNormal15 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: MyColors.black,
  );

  static const TextStyle textStyleMediumWhite15 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: MyColors.white,
  );

  static const TextStyle textStyleMedium17 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: MyColors.black,
  );

  static const TextStyle textStyleMedium17Red = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: MyColors.red,
  );

  static const TextStyle textStyleMedium17Green = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: MyColors.green,
  );

  static const TextStyle textStyleMedium17Blue = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: MyColors.blue,
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
  static const Color blue = Color(0xFF0084FF);
  static const Color green = Color(0xFF38AD52);
  static const Color red = Color(0xFFFF0000);
  static const Color black = Color(0xFF000000);
  static const Color black10 = Color(0x1A0A0A0A);
  static const Color grey = Color(0xFFD9D9D9);
  static const Color greyBackground = Color(0xFFEEEFF0);
}

class MyMaterialColors {
  static const MaterialColor blue = MaterialColor(_bluePrimaryValue, <int, Color>{
    50: Color(0xFF0084FF),
    100: Color(0xFF0084FF),
    200: Color(0xFF0084FF),
    300: Color(0xFF0084FF),
    400: Color(0xFF0084FF),
    500: Color(_bluePrimaryValue),
    600: Color(0xFF0084FF),
    700: Color(0xFF0084FF),
    800: Color(0xFF0084FF),
    900: Color(0xFF0084FF),
  });
  static const int _bluePrimaryValue = 0xFF0084FF;

  static const MaterialColor blueAccent = MaterialColor(_blueAccentValue, <int, Color>{
    100: Color(0xFF0084FF),
    200: Color(_blueAccentValue),
    400: Color(0xFF0084FF),
    700: Color(0xFF0084FF),
  });
  static const int _blueAccentValue = 0xFF0084FF;
}