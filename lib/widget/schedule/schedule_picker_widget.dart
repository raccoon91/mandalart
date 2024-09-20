import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/theme/color.dart';

class SchedulePickerWidget extends StatelessWidget {
  final int? id;
  final String? name;
  final Color? color;
  final double? width;
  final bool? selected;
  final void Function()? onTap;

  const SchedulePickerWidget({
    super.key,
    this.id,
    this.name,
    this.color,
    this.width,
    this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: selected == true ? color : ColorClass.white,
          border: Border.all(
            color: selected == true ? color ?? ColorClass.gray : ColorClass.gray,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
        ),
        child: Text(
          name ?? '',
          style: TextStyle(
            color: selected == true ? ColorClass.black : ColorClass.gray,
            fontSize: 18.sp,
            fontWeight: selected == true ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
