import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/model/task_model.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/calendar/calendar_date_time_range.dart';
import 'package:mandalart/widget/calendar/calendar_detailed_plan_picker.dart';
import 'package:mandalart/widget/calendar/calendar_plan_picker.dart';
import 'package:mandalart/widget/calendar/calendar_repeat_picker.dart';

class TaskBottomSheet extends StatelessWidget {
  final TaskModel? task;
  final DateTime? from;
  final DateTime? to;
  final Future<void> Function()? onDelete;
  final Future<void> Function()? onStop;

  const TaskBottomSheet({
    super.key,
    this.task,
    this.from,
    this.to,
    this.onDelete,
    this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, bottom: 20.h),
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
                    allDay: task?.allDay ?? false,
                  ),
                  const Divider(),
                  CalendarRepeatPicker(value: task?.repeat),
                  const Divider(),
                  CalendarPlanPicker(
                    selectedPlanId: task?.detailedPlan.planId,
                  ),
                  ...(task?.detailedPlan.planId != null
                      ? [
                          const Divider(),
                          CalendarDetailedPlanPicker(
                            selectedDetailedPlanId: task?.detailedPlan.id,
                          )
                        ]
                      : [])
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onDelete,
                  child: Column(
                    children: [
                      Icon(
                        Icons.clear,
                        size: 30.sp,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "삭제",
                        style: TextStyle(fontSize: 16.sp),
                      ),
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
                      Icon(
                        Icons.block,
                        size: 30.sp,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "종료",
                        style: TextStyle(fontSize: 16.sp),
                      ),
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
