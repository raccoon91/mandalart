import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/theme/color.dart';

class SettingCard extends StatelessWidget {
  final List<Widget> children;

  const SettingCard({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorClass.under,
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
