import 'package:flutter/material.dart';
import 'package:mandalart/model/color_model.dart';

class ColorWidget extends StatelessWidget {
  final bool? selected;
  final double? width;
  final double? height;
  final double? margin;
  final ColorModel color;

  const ColorWidget({
    super.key,
    this.selected,
    this.width,
    this.height,
    this.margin,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 60,
      height: height ?? 40,
      margin: EdgeInsets.all(margin ?? 0),
      decoration: BoxDecoration(
        color: color.color,
        borderRadius: BorderRadius.circular(2),
      ),
      child: selected == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  size: 12,
                  Icons.check,
                ),
                const SizedBox(width: 4),
                Text(
                  color.name,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                color.name,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
    );
  }
}
