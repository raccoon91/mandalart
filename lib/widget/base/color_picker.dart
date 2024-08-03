import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/color_widget.dart';

List<Color> colorList = [
  ColorClass.red,
  ColorClass.orange,
  ColorClass.yellow,
  ColorClass.mint,
  ColorClass.green,
  ColorClass.skyBlue,
  ColorClass.blue,
  ColorClass.pink,
  ColorClass.purple,
  ColorClass.under,
  ColorClass.border,
  ColorClass.gray,
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
        LayoutBuilder(
          builder: (context, constraints) => Wrap(
            children: List.generate(
              colorList.length,
              (index) => GestureDetector(
                onTap: colorTapped(colorList[index]),
                child: ColorWidget(
                  margin: 6.w,
                  color: colorList[index],
                  selected: color == colorList[index],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
