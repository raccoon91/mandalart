import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/widget/calendar/calendar_repeat_widget.dart';

class CalendarRepeatPicker extends StatelessWidget {
  final String? value;
  final void Function(String? value)? onChanged;

  const CalendarRepeatPicker({
    super.key,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 40.w),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.repeat),
              SizedBox(width: 10.w),
              Text('반복', style: TextStyle(fontSize: 20.sp))
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CalendarRepeatWidget(
                value: "weekdays",
                name: "주중",
                selected: value == "weekdays",
                onChanged: onChanged,
              ),
              SizedBox(width: 10.w),
              CalendarRepeatWidget(
                value: "weekend",
                name: "주말",
                selected: value == "weekend",
                onChanged: onChanged,
              ),
              SizedBox(width: 10.w),
              CalendarRepeatWidget(
                value: "day",
                name: "매일",
                selected: value == "day",
                onChanged: onChanged,
              ),
              SizedBox(width: 10.w),
              CalendarRepeatWidget(
                value: "week",
                name: "매주",
                selected: value == "week",
                onChanged: onChanged,
              ),
              SizedBox(width: 10.w),
              CalendarRepeatWidget(
                value: "month",
                name: "매달",
                selected: value == "month",
                onChanged: onChanged,
              ),
            ],
          )
        ],
      ),
    );
  }
}
