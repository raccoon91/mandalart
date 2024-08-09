import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mandalart/theme/color.dart';

class TimePicker extends StatelessWidget {
  final DateTime date;
  final void Function(DateTime date)? onChange;

  const TimePicker({
    super.key,
    required this.date,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        final TimeOfDay? value = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(date),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: ColorClass.blue,
                secondary: ColorClass.skyBlue,
                onPrimary: ColorClass.black,
                onSurface: ColorClass.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: ColorClass.black,
                ),
              ),
            ),
            child: Localizations.override(
              context: context,
              locale: const Locale('ko'),
              child: child!,
            ),
          ),
        );

        if (value == null || onChange == null) return;

        onChange!(date.copyWith(hour: value.hour, minute: value.minute));
      },
      child: Text(
        DateFormat("a HH:mm").format(date),
        style: TextStyle(fontSize: 18.sp),
      ),
    );
  }
}
