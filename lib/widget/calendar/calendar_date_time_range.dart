import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/date_picker.dart';
import 'package:mandalart/widget/base/time_picker.dart';

class CalendarDateTimeRange extends StatelessWidget {
  final DateTime from;
  final DateTime to;
  final bool isAllDay;
  final void Function(DateTime date)? fromChanged;
  final void Function(DateTime date)? toChanged;
  final void Function(bool value)? allDayChanged;

  const CalendarDateTimeRange({
    super.key,
    required this.from,
    required this.to,
    required this.isAllDay,
    this.fromChanged,
    this.toChanged,
    this.allDayChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 40.w,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time),
                  SizedBox(width: 10.w),
                  Text('날짜', style: TextStyle(fontSize: 20.sp))
                ],
              ),
              SizedBox(
                height: 30.h,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    activeColor: ColorClass.blue,
                    activeTrackColor: ColorClass.skyBlue,
                    inactiveTrackColor: ColorClass.under,
                    value: isAllDay,
                    onChanged: allDayChanged,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              SizedBox(width: 40.w),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DatePicker(
                      date: from,
                      onChange: fromChanged,
                    ),
                    TimePicker(
                      date: from,
                      onChange: fromChanged,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              SizedBox(width: 40.w),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TimePicker(
                      date: to,
                      onChange: toChanged,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
