import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/theme/color.dart';

class RepeatWidget extends StatelessWidget {
  final String value;
  final String name;
  final bool selected;
  final void Function(String value)? onChanged;

  const RepeatWidget({
    super.key,
    required this.value,
    required this.name,
    this.selected = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (onChanged == null) return;

        onChanged!(value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: selected ? ColorClass.border : ColorClass.white,
          border: Border.all(
            color: selected ? ColorClass.border : ColorClass.gray,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
