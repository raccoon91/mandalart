import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/widget/base/date_picker.dart';
import 'package:mandalart/widget/base/time_picker.dart';

class CalendarDateTimeRange extends StatelessWidget {
  final DateTime from;
  final DateTime to;
  final void Function(DateTime date)? fromChanged;
  final void Function(DateTime date)? toChanged;

  const CalendarDateTimeRange({
    super.key,
    required this.from,
    required this.to,
    this.fromChanged,
    this.toChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 20.w,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.access_time),
              SizedBox(width: 10.w),
              Text(
                "날짜",
                style: TextStyle(fontSize: 18.sp),
              )
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DatePicker(
                      date: to,
                      onChange: toChanged,
                    ),
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
