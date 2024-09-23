import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/theme/color.dart';

class ToggleButton extends StatelessWidget {
  final String text;
  final Color? color;
  final bool selected;
  final Widget? right;
  final void Function()? onPressed;

  const ToggleButton({
    super.key,
    required this.text,
    this.color,
    this.selected = false,
    this.right,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 12.h, horizontal: 24.w),
                  foregroundColor: ColorClass.black,
                  backgroundColor: selected ? color ?? ColorClass.border : ColorClass.under,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                ),
                onPressed: onPressed,
                child: Text(
                  text,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ] +
          (right == null
              ? []
              : [
                  SizedBox(width: 20.w),
                  right!,
                ]),
    );
  }
}
