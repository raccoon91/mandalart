import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mandalart/theme/color.dart';

class ThemeClass {
  static ThemeData theme = ThemeData(
    primaryColor: ColorClass.blue,
    fontFamily: 'NanumSquareRound',
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorClass.blue,
      selectionColor: ColorClass.blue,
      selectionHandleColor: ColorClass.blue,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
  );
}
