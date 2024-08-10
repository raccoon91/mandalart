import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/widget/calendar/calendar_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CalendarBottomSheetScreen extends StatefulWidget {
  final String? from;
  final String? to;

  const CalendarBottomSheetScreen({
    super.key,
    this.from,
    this.to,
  });

  @override
  State<CalendarBottomSheetScreen> createState() =>
      _CalendarBottomSheetScreenState();
}

class _CalendarBottomSheetScreenState extends State<CalendarBottomSheetScreen> {
  late DateTime from;
  late DateTime to;

  @override
  void initState() {
    super.initState();

    from = DateTime.parse(widget.from ?? "");
    to = DateTime.parse(widget.to ?? "");
  }

  Future<void> createTask(
    int detailedPlanId,
    DateTime from,
    DateTime to,
    bool? allDay,
    String? repeat,
  ) async {
    bool success = await Provider.of<CalendarProvider>(
      context,
      listen: false,
    ).createTask(
      detailedPlanId,
      from,
      to,
      allDay,
      repeat,
    );

    if (!mounted || success == false) return;

    await Provider.of<CalendarProvider>(
      context,
      listen: false,
    ).getTasks(from, to);

    if (!mounted) return;

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return CalendarBottomSheet(
      from: from,
      to: to,
      onCreate: createTask,
    );
  }
}
