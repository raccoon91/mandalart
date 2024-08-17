import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/model/task_model.dart';
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

  void getTasks(DateTime date) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(
        context,
        listen: false,
      ).getTasks(date);
    });
  }

  onTapCell(CalendarTapDetails? calendar) async {
    if (calendar?.appointments == null) return;

    TaskModel? task = calendar?.appointments?.first;

    if (task == null || calendar?.date == null) return;

    await Provider.of<TaskProvider>(
      context,
      listen: false,
    ).toggleTodo(
      task.completeId,
      task.scheduleId,
      task.startTime,
    );

    if (!mounted) return;

    DateTime date = calendar!.date!;

    await Provider.of<TaskProvider>(
      context,
      listen: false,
    ).updateTask(task.scheduleId, date);
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
            child: Consumer<TaskProvider>(
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
                appointmentBuilder: (context, calendar) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: calendar.appointments.map((task) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.all(2.sp),
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                            color: task?.color,
                            border: Border.all(
                              color: task?.borderColor,
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.r),
                            ),
                          ),
                          child: Text(task?.subject),
                        ),
                      );
                    }).toList(),
                  );
                },
                dataSource: state.tasks,
                onViewChanged: (view) {
                  DateTime date = view.visibleDates.first;

                  getTasks(date);
                },
                onTap: onTapCell,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
