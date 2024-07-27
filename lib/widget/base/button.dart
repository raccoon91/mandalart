import 'package:flutter/material.dart';
import 'package:mandalart/theme/color.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const Button({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorClass.skyBlue,
        foregroundColor: ColorClass.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
