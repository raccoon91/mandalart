import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/base/color_picker.dart';
import 'package:mandalart/widget/base/input.dart';
import 'package:mandalart/widget/home/card_widget.dart';

class PlanBottomSheet extends StatefulWidget {
  final String type;
  final int? planId;
  final int? detailedPlanId;
  final Future<void> Function(String name, Color color)? create;

  const PlanBottomSheet({
    super.key,
    required this.type,
    this.planId,
    this.detailedPlanId,
    this.create,
  });

  @override
  State<PlanBottomSheet> createState() => _PlanBottomSheetState();
}

class _PlanBottomSheetState extends State<PlanBottomSheet> {
  final nameController = TextEditingController();
  Color color = ColorClass.blue;
  bool enabled = false;

  colorTapped(Color color) {
    this.color = color;
    setState(() {});
  }

  nameChanged(String data) {
    if (data.isEmpty) {
      enabled = false;
    } else {
      enabled = true;
    }
    setState(() {});
  }

  createTapped() async {
    if (widget.create != null) {
      await widget.create!(
        nameController.text,
        color,
      );
    }

    if (!mounted) return;

    Navigator.of(context, rootNavigator: false).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 560.h,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Flexible(
                          flex: 1,
                          child: CardWidget(
                            name: nameController.text,
                            color: color,
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    ColorPicker(color: color, onTapped: colorTapped),
                    SizedBox(height: 30.h),
                    Input(
                      autofocus: true,
                      placeholder: '계획을 입력하세요',
                      controller: nameController,
                      onChanged: nameChanged,
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 60.h,
              child: Button(
                text: '만들기',
                onPressed: enabled ? createTapped : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
