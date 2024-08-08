import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/calendar/calendar_date_time_range.dart';
import 'package:mandalart/widget/calendar/calendar_detailed_plan_picker.dart';
import 'package:mandalart/widget/calendar/calendar_plan_picker.dart';
import 'package:provider/provider.dart';

class CalendarBottomSheet extends StatefulWidget {
  final DateTime from;
  final DateTime to;
  final bool allDay;

  const CalendarBottomSheet({
    super.key,
    required this.from,
    required this.to,
    required this.allDay,
  });

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  late DateTime fromDate;
  late DateTime toDate;
  late bool allDay;
  int? selectedPlanId;
  int? selectedDetailedPlanId;

  @override
  void initState() {
    super.initState();

    fromDate = widget.from;
    toDate = widget.to;
    allDay = widget.allDay;
  }

  fromDateChanged(DateTime date) {
    fromDate = date;

    setState(() {});
  }

  toDateChanged(DateTime date) {
    toDate = date;

    setState(() {});
  }

  allDayChanged(bool value) {
    allDay = value;

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

    setState(() {});
  }

  detailedPlanChanged(int detailedPlanId) {
    if (selectedDetailedPlanId == detailedPlanId) {
      selectedDetailedPlanId = null;
    } else {
      selectedDetailedPlanId = detailedPlanId;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40.h, bottom: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              child: const Button(text: '만들기'),
            ),
          ),
        ],
      ),
    );
  }
}
