import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/theme/color.dart';

class EmptyWidget extends StatelessWidget {
  final String? mode;
  final int? planId;
  final double? size;

  const EmptyWidget({
    super.key,
    this.mode,
    this.planId,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          context.push('/sheet/plan/$planId');
        },
        child: Container(
          width: size ?? double.infinity,
          margin: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: ColorClass.under,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Icon(
            Icons.add,
            size: 30.sp,
            color: ColorClass.gray,
          ),
        ),
      ),
    );
  }
}
