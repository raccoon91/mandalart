import 'package:flutter/material.dart';

class ColorWidget extends StatelessWidget {
  final bool? selected;
  final double? width;
  final double? height;
  final double? margin;
  final Color color;

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
      width: width ?? 40,
      height: height ?? 40,
      margin: EdgeInsets.all(margin ?? 0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: selected == true
            ? const Icon(
                size: 16,
                Icons.check,
              )
            : null,
      ),
    );
  }
}
