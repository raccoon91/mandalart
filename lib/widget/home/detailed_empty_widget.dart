import 'package:flutter/material.dart';
import 'package:mandalart/theme/color.dart';

class DetailedEmptyWidget extends StatelessWidget {
  final String? type;
  final double? size;

  const DetailedEmptyWidget({
    super.key,
    this.type,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        child: Container(
          width: size ?? double.infinity,
          margin: const EdgeInsets.all(3),
          decoration: type == "plan"
              ? BoxDecoration(
                  color: ColorClass.under,
                  borderRadius: BorderRadius.circular(4),
                )
              : BoxDecoration(
                  border: Border.all(color: ColorClass.under),
                  borderRadius: BorderRadius.circular(4),
                ),
          child: const Icon(
            Icons.add,
            size: 10,
            color: ColorClass.gray,
          ),
        ),
      ),
    );
  }
}
