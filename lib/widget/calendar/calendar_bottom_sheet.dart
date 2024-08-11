import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/calendar/calendar_date_time_range.dart';
import 'package:mandalart/widget/calendar/calendar_detailed_plan_picker.dart';
import 'package:mandalart/widget/calendar/calendar_plan_picker.dart';
import 'package:mandalart/widget/calendar/calendar_repeat_picker.dart';
import 'package:provider/provider.dart';

class CalendarBottomSheet extends StatefulWidget {
  final DateTime from;
  final DateTime to;
  final Future<void> Function(
    int detailedPlanId,
    DateTime from,
    DateTime to,
    bool? allDay,
    String? repeat,
  )? onCreate;

  const CalendarBottomSheet({
    super.key,
    required this.from,
    required this.to,
    this.onCreate,
  });

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  int? selectedPlanId;
  int? selectedDetailedPlanId;
  late DateTime fromDate;
  late DateTime toDate;
  bool allDay = false;
  String? repeat;
  bool enabled = false;

  @override
  void initState() {
    super.initState();

    fromDate = widget.from;
    toDate = widget.to;
  }

  checkEnabled() {
    enabled = selectedPlanId != null && selectedDetailedPlanId != null;
  }

  fromDateChanged(DateTime date) {
    fromDate = date;
    toDate = toDate.copyWith(
      year: fromDate.year,
      month: fromDate.month,
      day: fromDate.day,
    );

    checkEnabled();

    setState(() {});
  }

  toDateChanged(DateTime date) {
    toDate = date.copyWith(
      year: fromDate.year,
      month: fromDate.month,
      day: fromDate.day,
    );

    checkEnabled();

    setState(() {});
  }

  allDayChanged(bool value) {
    allDay = value;

    checkEnabled();

    setState(() {});
  }

  repeatChanged(String? value) {
    if (repeat == value) {
      repeat = null;
    } else {
      repeat = value;
    }

    setState(() {});
  }

  planChanged(int planId) {
    if (selectedPlanId == planId) {
      selectedPlanId = null;
    } else {
      selectedPlanId = planId;
    }

    selectedDetailedPlanId = null;

    Provider.of<CalendarProvider>(
      context,
      listen: false,
    ).getDetailedPlans(selectedPlanId);

    checkEnabled();

    setState(() {});
  }

  detailedPlanChanged(int detailedPlanId) {
    if (selectedDetailedPlanId == detailedPlanId) {
      selectedDetailedPlanId = null;
    } else {
      selectedDetailedPlanId = detailedPlanId;
    }

    checkEnabled();

    setState(() {});
  }

  createTapped() {
    if (widget.onCreate == null || selectedDetailedPlanId == null) return;

    widget.onCreate!(selectedDetailedPlanId!, fromDate, toDate, allDay, repeat);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, bottom: 20.h),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorClass.gray,
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
            ),
          ),
          SizedBox(height: 30.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CalendarDateTimeRange(
                    from: fromDate,
                    to: toDate,
                    allDay: allDay,
                    fromChanged: fromDateChanged,
                    toChanged: toDateChanged,
                    allDayChanged: allDayChanged,
                  ),
                  const Divider(),
                  CalendarRepeatPicker(
                    value: repeat,
                    onChanged: repeatChanged,
                  ),
                  const Divider(),
                  CalendarPlanPicker(
                    selectedPlanId: selectedPlanId,
                    onChanged: planChanged,
                  ),
                  ...(selectedPlanId != null
                      ? [
                          const Divider(),
                          CalendarDetailedPlanPicker(
                            selectedDetailedPlanId: selectedDetailedPlanId,
                            onChanged: detailedPlanChanged,
                          )
                        ]
                      : [])
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: SizedBox(
              width: double.infinity,
              height: 60.h,
              child: Button(
                text: '시작하기',
                onPressed:
                    enabled && widget.onCreate != null ? createTapped : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
