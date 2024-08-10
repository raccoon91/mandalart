import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/theme/color.dart';

class CalendarRepeatWidget extends StatelessWidget {
  final String? value;
  final void Function(String? value)? onChanged;

  const CalendarRepeatWidget({
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
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (onChanged == null) return;

                  onChanged!("day");
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 18.w),
                  decoration: BoxDecoration(
                    color:
                        value == "day" ? ColorClass.border : ColorClass.white,
                    border: Border.all(
                      color:
                          value == "day" ? ColorClass.border : ColorClass.gray,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  ),
                  child: Text(
                    '매일',
                    style: TextStyle(
                      fontWeight:
                          value == "day" ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (onChanged == null) return;

                  onChanged!("week");
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 18.w),
                  decoration: BoxDecoration(
                    color:
                        value == "week" ? ColorClass.border : ColorClass.white,
                    border: Border.all(
                      color:
                          value == "week" ? ColorClass.border : ColorClass.gray,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  ),
                  child: Text(
                    '매주',
                    style: TextStyle(
                      fontWeight:
                          value == "week" ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (onChanged == null) return;

                  onChanged!("month");
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 18.w),
                  decoration: BoxDecoration(
                    color:
                        value == "month" ? ColorClass.border : ColorClass.white,
                    border: Border.all(
                      color: value == "month"
                          ? ColorClass.border
                          : ColorClass.gray,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  ),
                  child: Text(
                    '매달',
                    style: TextStyle(
                      fontWeight:
                          value == "month" ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
