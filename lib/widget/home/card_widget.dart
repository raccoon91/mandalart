import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  final String? name;
  final Color? color;
  final void Function()? onTap;
  final double? size;

  const CardWidget({
    super.key,
    this.name,
    this.color,
    this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Container(
          width: size,
          margin: EdgeInsets.all(3.w),
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Center(
            child: Text(
              name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
