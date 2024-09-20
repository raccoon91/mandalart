import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/appointment_model.dart';
import 'package:mandalart/provider/schedule_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/banner_ad.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late DateTime weekFrom;
  late DateTime weekTo;

  @override
  void initState() {
    super.initState();

    getScheduleScreenData();
  }

  void getScheduleScreenData() {
    Provider.of<ScheduleProvider>(context, listen: false).getGoals();
  }

  void getSchedules(DateTime from, DateTime to) {
    Provider.of<ScheduleProvider>(context, listen: false).getSchedules(from: from, to: to);
  }

  clickCell(CalendarTapDetails? calendar) {
    if (calendar?.appointments == null) {
      if (calendar?.date == null) return;

      context.push('/sheet/schedule/create/${calendar?.date.toString()}');
    } else {
      AppointmentModel? appointment = calendar?.appointments?.first;

      if (appointment == null) return;

      context.push(
        '/sheet/schedule/${appointment.scheduleId}/${appointment.startTime.toString()}/${appointment.endTime.toString()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      padding: EdgeInsets.only(top: 10.h),
      body: Column(
        children: [
          const BannerAD(),
          SizedBox(height: 10.h),
          Expanded(
            child: Consumer<ScheduleProvider>(
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
                dataSource: state.appointments,
                onTap: clickCell,
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
