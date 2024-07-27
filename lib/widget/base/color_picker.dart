import 'package:flutter/material.dart';
import 'package:mandalart/model/color_model.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/color_widget.dart';

List<ColorModel> colorList = [
  ColorMap.red,
  ColorMap.blue,
  ColorMap.orange,
  ColorMap.green,
  ColorMap.skyBlue,
  ColorMap.purple,
  ColorMap.pink,
  ColorMap.yellow,
  ColorMap.mint,
];

class ColorPicker extends StatelessWidget {
  final Color? color;
  final void Function(Color color)? onTapped;

  const ColorPicker({
    super.key,
    this.color,
    this.onTapped,
  });

  colorTapped(ColorModel color) {
    return () {
      if (onTapped != null) onTapped!(color.color);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) => Wrap(
            spacing: 5,
            runSpacing: 5,
            children: List.generate(
              colorList.length,
              (index) => GestureDetector(
                onTap: colorTapped(colorList[index]),
                child: ColorWidget(
                  selected: color == colorList[index].color,
                  width: (constraints.maxWidth / 3) - (5 * 2),
                  color: colorList[index],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
