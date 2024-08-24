import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/schedule_provider.dart';
import 'package:mandalart/provider/task_provider.dart';
import 'package:mandalart/widget/schedule/schedule_create_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ScheduleCreateBottomSheetScreen extends StatefulWidget {
  final String? date;

  const ScheduleCreateBottomSheetScreen({
    super.key,
    this.date,
  });

  @override
  State<ScheduleCreateBottomSheetScreen> createState() =>
      _ScheduleCreateBottomSheetScreenState();
}

class _ScheduleCreateBottomSheetScreenState
    extends State<ScheduleCreateBottomSheetScreen> {
  late DateTime from;
  late DateTime to;

  @override
  void initState() {
    super.initState();

    from = DateTime.parse(widget.date ?? '');
    to = from.add(const Duration(hours: 1));
  }

  Future<void> createTask(
    int planId,
    DateTime from,
    DateTime to,
    bool? allDay,
    String? repeat,
  ) async {
    bool success = await Provider.of<ScheduleProvider>(context, listen: false)
        .createSchedule(
      planId,
      from,
      to,
      allDay,
      repeat,
    );

    if (!mounted || success == false) return;

    await Provider.of<ScheduleProvider>(context, listen: false).getSchedules(
      null,
      null,
    );

    if (!mounted) return;

    await Provider.of<TaskProvider>(context, listen: false).getTasks(
      DateTime.now(),
    );

    if (!mounted) return;

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScheduleCreateBottomSheet(
      from: from,
      to: to,
      onCreate: createTask,
    );
  }
}
