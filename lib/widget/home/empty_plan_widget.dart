import 'package:flutter/material.dart';
import 'package:mandalart/theme/color.dart';

class EmptyPlanWidget extends StatelessWidget {
  final Color? color;
  final double? size;
  final void Function()? onTap;

  const EmptyPlanWidget({
    super.key,
    this.color,
    this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size ?? double.infinity,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color ?? ColorClass.under,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.add,
            size: 20,
            color: ColorClass.black,
          ),
        ),
      ),
    );
  }
}
