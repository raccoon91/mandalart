import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/theme/color.dart';

class PlanEmptyWidget extends StatelessWidget {
  final String? mode;
  final String? type;
  final PlanModel? plan;
  final double? size;

  const PlanEmptyWidget({
    super.key,
    this.mode,
    this.type,
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
            '/sheet/plan/$mode/${plan!.goalId}/${plan!.id}',
          );
        },
        child: Container(
          width: size ?? double.infinity,
          margin: EdgeInsets.all(3.w),
          decoration: type == 'goal'
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
            size: type == 'goal' ? 30.sp : 16.sp,
            color: ColorClass.gray,
          ),
        ),
      ),
    );
  }
}
