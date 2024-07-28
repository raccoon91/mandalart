import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/base/color_picker.dart';
import 'package:mandalart/widget/base/input.dart';
import 'package:mandalart/widget/base/layout.dart';
import 'package:provider/provider.dart';

class PlanCreateScreen extends StatefulWidget {
  final String? projectId;
  final String? planId;

  const PlanCreateScreen({
    super.key,
    required this.projectId,
    required this.planId,
  });

  @override
  State<PlanCreateScreen> createState() => _PlanCreateScreenState();
}

class _PlanCreateScreenState extends State<PlanCreateScreen> {
  final planController = TextEditingController();
  Color color = ColorClass.skyBlue;
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
    await Provider.of<HomeProvider>(context, listen: false).updateMandal(
      widget.planId != null ? int.parse(widget.planId!) : null,
      planController.text,
      color,
    );

    if (!mounted) return;

    context.go("/");
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "계획",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorPicker(color: color, onTapped: colorTapped),
            const SizedBox(height: 30),
            Input(
              autofocus: true,
              placeholder: "계획을 입력하세요",
              controller: planController,
              onChanged: nameChanged,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: Button(
                text: "계획 만들기",
                onPressed: enabled ? createTapped : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
