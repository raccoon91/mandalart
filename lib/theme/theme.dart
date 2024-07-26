import 'package:flutter/material.dart';
import 'package:mandalart/theme/color.dart';

class ThemeClass {
  static ThemeData theme = ThemeData(
    fontFamily: 'NanumSquareRound',
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorClass.blue,
      selectionColor: ColorClass.blue,
      selectionHandleColor: ColorClass.blue,
    ),
  );
}
