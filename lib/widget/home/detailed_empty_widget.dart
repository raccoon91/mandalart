import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/theme/color.dart';

class DetailedEmptyWidget extends StatelessWidget {
  final String? mode;
  final String? type;
  final DetailedPlanModel? detailedPlan;
  final double? size;

  const DetailedEmptyWidget({
    super.key,
    this.mode,
    this.type,
    this.detailedPlan,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (detailedPlan?.planId == null || detailedPlan?.id == null) return;

          context.push(
            '/sheet/detailed/$mode/${detailedPlan!.planId}/${detailedPlan!.id}',
          );
        },
        child: Container(
          width: size ?? double.infinity,
          margin: EdgeInsets.all(3.w),
          decoration: type == 'plan'
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
            size: type == 'plan' ? 30.sp : 16.sp,
            color: ColorClass.gray,
          ),
        ),
      ),
    );
  }
}
