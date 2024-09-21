import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mandalart/theme/color.dart';

class ThemeClass {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'NanumSquareRound',
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorClass.blue,
      selectionColor: ColorClass.blue,
      selectionHandleColor: ColorClass.blue,
    ),
    scaffoldBackgroundColor: ColorClass.background,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      foregroundColor: ColorClass.white,
      backgroundColor: ColorClass.primary,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: ColorClass.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'NanumSquareRound',
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: ColorClass.white,
      selectedItemColor: ColorClass.primary,
      unselectedItemColor: ColorClass.border,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(),
      foregroundColor: ColorClass.white,
      backgroundColor: ColorClass.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: ColorClass.white,
        backgroundColor: ColorClass.primary,
        disabledForegroundColor: ColorClass.black,
        disabledBackgroundColor: ColorClass.under,
      ),
    ),
  );
}
