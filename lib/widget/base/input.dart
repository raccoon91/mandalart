import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/theme/color.dart';

class Input extends StatelessWidget {
  final bool? autofocus;
  final String placeholder;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const Input({
    super.key,
    this.autofocus,
    this.placeholder = '텍스트를 입력해주세요',
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.maxLines,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autofocus: autofocus == true,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: placeholder,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: const BorderSide(
            color: ColorClass.gray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: const BorderSide(
            color: ColorClass.blue,
          ),
        ),
      ),
    );
  }
}
