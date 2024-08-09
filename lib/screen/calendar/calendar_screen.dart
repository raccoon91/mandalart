import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/utils/task_data_source.dart';
import 'package:mandalart/widget/base/banner_ad.dart';
import 'package:mandalart/widget/calendar/calendar_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTasksAndPlans();
    });
  }

  void getTasksAndPlans() async {
    await Provider.of<CalendarProvider>(
      context,
      listen: false,
    ).getTasks();

    if (!mounted) return;

    await Provider.of<CalendarProvider>(
      context,
      listen: false,
    ).getPlans();
  }

  Future<void> createTask(
    int detailedPlanId,
    DateTime from,
    DateTime to,
    bool? allDay,
    bool? everyDay,
    int? everyWeek,
    int? everyMonth,
  ) async {
    bool success = await Provider.of<CalendarProvider>(
      context,
      listen: false,
    ).createTask(
      detailedPlanId,
      from,
      to,
      allDay,
      everyDay,
      everyWeek,
      everyMonth,
    );

    if (!mounted || success == false) return;

    await Provider.of<CalendarProvider>(
      context,
      listen: false,
    ).getTasks();

    if (!mounted) return;

    context.pop();
  }

  onTapCell(CalendarTapDetails? calendar) {
    DateTime from = calendar?.date ?? DateTime.now();
    DateTime to = from.add(const Duration(hours: 1));

    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: ColorClass.white,
      builder: (BuildContext context) {
        return CalendarBottomSheet(
          from: from,
          to: to,
          onCreate: createTask,
        );
      },
    );
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
                timeZone: "Asia/Seoul",
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
                dataSource: TaskDataSource(state.tasks),
                onTap: onTapCell,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
