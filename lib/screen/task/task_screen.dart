import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/provider/task_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/banner_ad.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late DateTime weekFrom;
  late DateTime weekTo;

  void getTodayTasks(DateTime date) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(
        context,
        listen: false,
      ).getTodayTasks(date);
    });
  }

  onTapCell(CalendarTapDetails? calendar) {
    if (calendar?.appointments == null) {
      if (calendar?.date == null) return;
    } else {
      Appointment appointment = calendar?.appointments?.first;
      dynamic task = appointment.resourceIds
          ?.firstWhere((dynamic resource) => resource?['taskId'] != null);

      if (task == null) return;
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
                view: CalendarView.day,
                timeZone: 'Asia/Seoul',
                showCurrentTimeIndicator: true,
                initialDisplayDate: DateTime.now(),
                showTodayButton: true,
                headerDateFormat: 'yyyy년 MM월',
                headerStyle: const CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(fontWeight: FontWeight.w700),
                  backgroundColor: ColorClass.under,
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
                appointmentBuilder: (context, calendarAppointmentDetails) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: calendarAppointmentDetails.appointments
                        .map((appointment) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.all(2.sp),
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                            color: appointment?.color,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.r),
                            ),
                          ),
                          child: Text(appointment?.subject),
                        ),
                      );
                    }).toList(),
                  );
                },
                dataSource: state.tasks,
                onViewChanged: (view) {
                  DateTime date = view.visibleDates.first;

                  getTodayTasks(date);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
