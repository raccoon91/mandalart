import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mandalart/theme/color.dart';

class DatePicker extends StatelessWidget {
  final DateTime date;
  final void Function(DateTime date)? onChange;

  const DatePicker({
    super.key,
    required this.date,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        if (onChange == null) return;

        final DateTime? value = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: ColorClass.blue,
                onPrimary: ColorClass.black,
                onSurface: ColorClass.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: ColorClass.black,
                ),
              ),
            ),
            child: child!,
          ),
        );

        if (value == null || onChange == null) return;

        onChange!(value.copyWith(hour: date.hour, minute: date.minute));
      },
      child: Text(
        DateFormat('yyyy년 MM월 dd일').format(date),
        style: TextStyle(fontSize: 20.sp),
      ),
    );
  }
}
