import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/theme/color.dart';

class GoalEmptyWidget extends StatelessWidget {
  final String? mode;
  final int? goalId;
  final double? size;

  const GoalEmptyWidget({
    super.key,
    this.mode,
    this.goalId,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          context.push('/sheet/goal/$goalId');
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
