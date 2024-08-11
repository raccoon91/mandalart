import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/widget/calendar/task_bottom_sheet.dart';
import 'package:provider/provider.dart';

class TaskBottomSheetScreen extends StatefulWidget {
  final String? taskId;
  final String? from;
  final String? to;

  const TaskBottomSheetScreen({
    super.key,
    this.taskId,
    this.from,
    this.to,
  });

  @override
  State<TaskBottomSheetScreen> createState() => _TaskBottomSheetScreenState();
}

class _TaskBottomSheetScreenState extends State<TaskBottomSheetScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTask();
    });
  }

  void getTask() async {
    if (widget.taskId == null) return;

    await Provider.of<CalendarProvider>(
      context,
      listen: false,
    ).getTask(int.parse(widget.taskId!));
  }

  Future<void> deleteTask() async {
    if (widget.taskId == null) return;

    await Provider.of<CalendarProvider>(
      context,
      listen: false,
    ).deleteTask(int.parse(widget.taskId!));

    if (!mounted) return;

    await Provider.of<CalendarProvider>(
      context,
      listen: false,
    ).getTasks(null, null);

    if (!mounted) return;

    context.pop();
  }

  Future<void> stopTask() async {
    if (widget.taskId == null || widget.to == null) return;

    await Provider.of<CalendarProvider>(
      context,
      listen: false,
    ).stopTask(int.parse(widget.taskId!), DateTime.parse(widget.to!));

    if (!mounted) return;

    await Provider.of<CalendarProvider>(
      context,
      listen: false,
    ).getTasks(null, null);

    if (!mounted) return;

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarProvider>(
      builder: (context, state, child) {
        if (state.task == null) return Container();

        return TaskBottomSheet(
          task: state.task,
          from: widget.from != null ? DateTime.parse(widget.from!) : null,
          to: widget.to != null ? DateTime.parse(widget.to!) : null,
          onDelete: deleteTask,
          onStop: stopTask,
        );
      },
    );
  }
}
