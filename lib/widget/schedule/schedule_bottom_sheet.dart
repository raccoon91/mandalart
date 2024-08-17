import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/model/schedule_model.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/schedule/calendar_date_time_range.dart';
import 'package:mandalart/widget/schedule/goal_picker.dart';
import 'package:mandalart/widget/schedule/plan_picker.dart';
import 'package:mandalart/widget/schedule/repeat_picker.dart';

class ScheduleBottomSheet extends StatelessWidget {
  final ScheduleModel? schedule;
  final DateTime? from;
  final DateTime? to;
  final Future<void> Function()? onDelete;
  final Future<void> Function()? onStop;

  const ScheduleBottomSheet({
    super.key,
    this.schedule,
    this.from,
    this.to,
    this.onDelete,
    this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorClass.gray,
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
            ),
          ),
          SizedBox(height: 30.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CalendarDateTimeRange(
                    from: from ?? DateTime.now(),
                    to: to ?? DateTime.now(),
                    isAllDay: schedule?.isAllDay ?? false,
                  ),
                  const Divider(),
                  RepeatPicker(value: schedule?.repeat),
                  const Divider(),
                  GoalPicker(selectedGoalId: schedule?.plan?.goalId),
                  ...(schedule?.plan?.goalId != null
                      ? [
                          const Divider(),
                          PlanPicker(
                            selectedPlanId: schedule?.plan?.id,
                          )
                        ]
                      : [])
                ],
              ),
            ),
          ),
          const Divider(),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onDelete,
                  child: Column(
                    children: [
                      Icon(Icons.clear, size: 36.sp),
                      SizedBox(height: 6.h),
                      Text('삭제', style: TextStyle(fontSize: 16.sp)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onStop,
                  child: Column(
                    children: [
                      Icon(Icons.block, size: 36.sp),
                      SizedBox(height: 6.h),
                      Text('종료', style: TextStyle(fontSize: 16.sp)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
