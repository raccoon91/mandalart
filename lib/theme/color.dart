import 'package:flutter/material.dart';
import 'package:mandalart/model/color_model.dart';

class ColorClass {
  static const black = Color(0xFF282828);
  static const white = Color(0xFFFFFFFF);
  static const under = Color(0xFFFAFAFA);
  static const gray = Color(0xFFAEAEAE);
  static const red = Color(0xFFFFB3BA);
  static const orange = Color(0xFFFFDFBA);
  static const yellow = Color(0xFFFFFFBA);
  static const green = Color(0xFFBAFFC9);
  static const blue = Color(0xFF95C0F5);
  static const purple = Color(0xFFD7B2FF);
  static const pink = Color(0xFFFFC2E2);
  static const mint = Color(0xFFC2FFDF);
  static const skyBlue = Color(0xFFC2E0FF);
}

class ColorMap {
  static ColorModel black = ColorModel(
    name: 'Black',
    color: const Color(0xFF282828),
  );
  static ColorModel white = ColorModel(
    name: 'White',
    color: const Color(0xFFFFFFFF),
  );
  static ColorModel gray = ColorModel(
    name: 'Gray',
    color: const Color(0xFFEEEEEE),
  );
  static ColorModel red = ColorModel(
    name: 'Red',
    color: const Color(0xFFFFB3BA),
  );
  static ColorModel orange = ColorModel(
    name: 'Orange',
    color: const Color(0xFFFFDFBA),
  );
  static ColorModel yellow = ColorModel(
    name: 'Yellow',
    color: const Color(0xFFFFFFBA),
  );
  static ColorModel green = ColorModel(
    name: 'Green',
    color: const Color(0xFFBAFFC9),
  );
  static ColorModel blue = ColorModel(
    name: 'Blue',
    color: const Color(0xFF95C0F5),
  );
  static ColorModel purple = ColorModel(
    name: 'Purple',
    color: const Color(0xFFD7B2FF),
  );
  static ColorModel pink = ColorModel(
    name: 'Pink',
    color: const Color(0xFFFFC2E2),
  );
  static ColorModel mint = ColorModel(
    name: 'Mint',
    color: const Color(0xFFC2FFDF),
  );
  static ColorModel skyBlue = ColorModel(
    name: 'Sky Blue',
    color: const Color(0xFFC2E0FF),
  );
}
