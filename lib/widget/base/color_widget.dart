import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      width: width ?? 60.w,
      height: height ?? 60.w,
      margin: EdgeInsets.all(margin ?? 0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: selected == true
            ? Icon(
                size: 30.sp,
                Icons.check,
              )
            : null,
      ),
    );
  }
}
