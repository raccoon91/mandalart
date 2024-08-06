import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/home/plan_bottom_sheet.dart';
import 'package:provider/provider.dart';

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
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            useRootNavigator: true,
            isScrollControlled: true,
            backgroundColor: ColorClass.white,
            builder: (BuildContext context) {
              return PlanBottomSheet(
                type: 'plan',
                planId: planId,
                create: (String name, Color color) async {
                  await Provider.of<HomeProvider>(context, listen: false)
                      .upsertMandalPlan(
                    planId,
                    name,
                    color,
                  );

                  if (!context.mounted) return;

                  Provider.of<CalendarProvider>(context, listen: false)
                      .getPlans();
                },
              );
            },
          );
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
