import 'package:flutter/material.dart';
import 'package:mandalart/theme/color.dart';

const List<Color> colorList = [
  ColorClass.red,
  ColorClass.green,
  ColorClass.skyBlue,
  ColorClass.orange,
  ColorClass.white,
  ColorClass.purple,
  ColorClass.pink,
  ColorClass.yellow,
  ColorClass.mint,
  ColorClass.blue,
];

class ColorPicker extends StatelessWidget {
  final Color? color;
  final void Function(Color color)? onTapped;

  const ColorPicker({
    super.key,
    this.color,
    this.onTapped,
  });

  colorTapped(Color color) {
    return () {
      if (onTapped != null) onTapped!(color);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(
            5,
            (index) => Flexible(
              child: GestureDetector(
                onTap: colorTapped(colorList[index]),
                child: Container(
                  width: double.infinity,
                  height: 20,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: colorList[index],
                    border: Border.all(
                      color: color == colorList[index]
                          ? ColorClass.gray
                          : colorList[index],
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: List.generate(
            5,
            (index) => Flexible(
              child: GestureDetector(
                onTap: colorTapped(colorList[index + 5]),
                child: Container(
                  width: double.infinity,
                  height: 20,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: colorList[index + 5],
                    border: Border.all(
                      color: color == colorList[index + 5]
                          ? ColorClass.gray
                          : colorList[index + 5],
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
