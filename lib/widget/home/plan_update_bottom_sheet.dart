import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/base/color_picker.dart';
import 'package:mandalart/widget/base/input.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:provider/provider.dart';

class PlanUpdateBottomSheet extends StatefulWidget {
  final int? planId;
  final Future<void> Function(String name, Color color)? create;

  const PlanUpdateBottomSheet({
    super.key,
    this.planId,
    this.create,
  });

  @override
  State<PlanUpdateBottomSheet> createState() => _PlanUpdateBottomSheetState();
}

class _PlanUpdateBottomSheetState extends State<PlanUpdateBottomSheet> {
  final nameController = TextEditingController();
  Color color = ColorClass.border;
  bool enabled = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getGoal();
    });
  }

  getGoal() async {
    var plan = await Provider.of<HomeProvider>(context, listen: false).getPlan(
      widget.planId,
    );

    nameController.text = plan?.name ?? '';
    color = plan?.color ?? ColorClass.border;

    setState(() {});
  }

  colorTapped(Color color) {
    this.color = color;

    enabled = nameController.text.isNotEmpty == true;

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
    if (widget.create == null || nameController.text.isEmpty) return;

    await widget.create!(nameController.text, color);

    if (!mounted) return;

    context.pop();
  }

  submitted(String name) async {
    if (widget.create == null || name.isEmpty) return;

    await widget.create!(name, color);

    if (!mounted) return;

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).viewInsets.bottom + 530.h,
      child: Padding(
        padding: EdgeInsets.only(
          top: 30.h,
          right: 20.w,
          left: 20.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        child: Column(
          children: [
            Container(
              width: 80.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ColorClass.gray,
                borderRadius: BorderRadius.all(Radius.circular(4.r)),
              ),
            ),
            SizedBox(height: 30.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
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
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      onChanged: nameChanged,
                      onSubmitted: enabled ? submitted : null,
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
                text: '변경하기',
                onPressed: enabled ? createTapped : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
