import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/schedule_provider.dart';
import 'package:mandalart/provider/task_provider.dart';
import 'package:mandalart/widget/schedule/schedule_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ScheduleBottomSheetScreen extends StatefulWidget {
  final String? scheduleId;
  final String? from;
  final String? to;

  const ScheduleBottomSheetScreen({
    super.key,
    this.scheduleId,
    this.from,
    this.to,
  });

  @override
  State<ScheduleBottomSheetScreen> createState() =>
      _ScheduleBottomSheetScreenState();
}

class _ScheduleBottomSheetScreenState extends State<ScheduleBottomSheetScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSchedule();
    });
  }

  void getSchedule() async {
    if (widget.scheduleId == null) return;

    await Provider.of<ScheduleProvider>(context, listen: false).getSchedule(
      int.parse(widget.scheduleId!),
    );
  }

  Future<void> deleteSchedule() async {
    if (widget.scheduleId == null) return;

    await Provider.of<ScheduleProvider>(context, listen: false).deleteSchedule(
      int.parse(widget.scheduleId!),
    );

    if (!mounted) return;

    await Provider.of<ScheduleProvider>(context, listen: false).getSchedules(
      null,
      null,
    );

    if (!mounted) return;

    await Provider.of<TaskProvider>(context, listen: false).getTasks(null);

    if (!mounted) return;

    context.pop();
  }

  Future<void> stopSchedule() async {
    if (widget.scheduleId == null || widget.to == null) return;

    await Provider.of<ScheduleProvider>(context, listen: false).stopSchedule(
      int.parse(widget.scheduleId!),
      DateTime.parse(widget.to!),
    );

    if (!mounted) return;

    await Provider.of<ScheduleProvider>(context, listen: false).getSchedules(
      null,
      null,
    );

    if (!mounted) return;

    await Provider.of<TaskProvider>(context, listen: false).getTasks(null);

    if (!mounted) return;

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, state, child) {
        if (state.schedule == null) return Container();

        return ScheduleBottomSheet(
          schedule: state.schedule,
          from: widget.from != null ? DateTime.parse(widget.from!) : null,
          to: widget.to != null ? DateTime.parse(widget.to!) : null,
          onDelete: deleteSchedule,
          onStop: stopSchedule,
        );
      },
    );
  }
}
