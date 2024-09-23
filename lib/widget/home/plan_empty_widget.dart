import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/theme/color.dart';

class PlanEmptyWidget extends StatelessWidget {
  final String? route;
  final String? mode;
  final PlanModel? plan;
  final double? size;

  const PlanEmptyWidget({
    super.key,
    this.route,
    this.mode,
    this.plan,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (plan?.goalId == null || plan?.id == null) return;

          context.push(
            '/template/goal/${plan!.goalId}/plan/select/${plan!.id}',
          );
        },
        child: Container(
          width: size ?? double.infinity,
          margin: EdgeInsets.all(3.w),
          decoration: route == 'goal'
              ? BoxDecoration(
                  color: ColorClass.under,
                  borderRadius: BorderRadius.circular(4.r),
                )
              : BoxDecoration(
                  border: Border.all(color: ColorClass.under),
                  borderRadius: BorderRadius.circular(4.r),
                ),
          child: Icon(
            Icons.add,
            size: route == 'goal' ? 30.sp : 16.sp,
            color: ColorClass.gray,
          ),
        ),
      ),
    );
  }
}
