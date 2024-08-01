import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/base/color_picker.dart';
import 'package:mandalart/widget/base/input.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:provider/provider.dart';

class PlanBottomSheet extends StatefulWidget {
  final String type;
  final int? planId;
  final int? detailedPlanId;

  const PlanBottomSheet({
    super.key,
    required this.type,
    this.planId,
    this.detailedPlanId,
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

  createPlan() async {
    await Provider.of<HomeProvider>(context, listen: false).upsertMandalPlan(
      widget.planId,
      nameController.text,
      color,
    );
  }

  createDetailedPlan() async {
    await Provider.of<HomeProvider>(context, listen: false)
        .upsertMandalDetailedPlan(
      widget.planId,
      widget.detailedPlanId,
      nameController.text,
      color,
    );
  }

  createTapped() async {
    if (widget.type == 'plan') {
      await createPlan();
    } else if (widget.type == 'detailedPlan') {
      await createDetailedPlan();
    }

    if (!mounted) return;

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 30),
                    ColorPicker(color: color, onTapped: colorTapped),
                    const SizedBox(height: 30),
                    Input(
                      autofocus: true,
                      placeholder: "계획을 입력하세요",
                      controller: nameController,
                      onChanged: nameChanged,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Button(
                text: "만들기",
                onPressed: enabled ? createTapped : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}