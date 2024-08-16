import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/calendar_schedule_model.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/banner_ad.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime weekFrom;
  late DateTime weekTo;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CalendarProvider>(
        context,
        listen: false,
      ).getGoals();
    });
  }

  void getSchedules(DateTime from, DateTime to) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CalendarProvider>(
        context,
        listen: false,
      ).getSchedules(from, to);
    });
  }

  onTapCell(CalendarTapDetails? calendar) {
    if (calendar?.appointments == null) {
      if (calendar?.date == null) return;

      context.push('/sheet/calendar/${calendar?.date.toString()}');
    } else {
      CalendarScheduleModel? schedule = calendar?.appointments?.first;

      if (schedule == null) return;

      context.push(
        '/sheet/schedule/${schedule.scheduleId}/${schedule.startTime.toString()}/${schedule.endTime.toString()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          const BannerAD(),
          SizedBox(height: 10.h),
          Expanded(
            child: Consumer<CalendarProvider>(
              builder: (context, state, child) => SfCalendar(
                view: CalendarView.week,
                timeZone: 'Asia/Seoul',
                showWeekNumber: true,
                showTodayButton: true,
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
                  border: Border.all(width: 2, color: ColorClass.blue),
                ),
                appointmentTextStyle: TextStyle(
                  color: ColorClass.black,
                  fontSize: 14.sp,
                ),
                dataSource: state.calendarSchedules,
                onTap: onTapCell,
                onViewChanged: (view) {
                  weekFrom = view.visibleDates.first;
                  weekTo = view.visibleDates.last;

                  getSchedules(weekFrom, weekTo);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
