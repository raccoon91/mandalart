import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/banner_ad.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          const BannerAD(),
          SizedBox(height: 10.h),
          Expanded(
            child: SfCalendar(
              view: CalendarView.week,
              timeZone: "	Asia/Seoul",
              showWeekNumber: true,
              showCurrentTimeIndicator: true,
              initialDisplayDate: DateTime.now(),
              headerDateFormat: 'yyyy년 MM월',
              headerStyle: const CalendarHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyle(fontWeight: FontWeight.w700),
                backgroundColor: ColorClass.under,
              ),
              weekNumberStyle: const WeekNumberStyle(
                backgroundColor: ColorClass.under,
                textStyle: TextStyle(fontWeight: FontWeight.w700),
              ),
              todayHighlightColor: ColorClass.blue,
              todayTextStyle: const TextStyle(
                color: ColorClass.black,
                fontWeight: FontWeight.w700,
              ),
              selectionDecoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: ColorClass.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
