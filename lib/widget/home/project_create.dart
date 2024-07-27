import 'package:flutter/material.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/base/color_picker.dart';
import 'package:mandalart/widget/base/input.dart';
import 'package:provider/provider.dart';

class ProjectCreate extends StatefulWidget {
  const ProjectCreate({super.key});

  @override
  State<ProjectCreate> createState() => _ProjectCreateState();
}

class _ProjectCreateState extends State<ProjectCreate> {
  final projectController = TextEditingController();
  Color color = ColorClass.red;
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
    Provider.of<HomeProvider>(context, listen: false).createProject(
      projectController.text,
      color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ColorPicker(color: color, onTapped: colorTapped),
        const SizedBox(height: 30),
        Input(
          autofocus: true,
          controller: projectController,
          onChanged: nameChanged,
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: Button(
            text: "Create Project",
            onPressed: enabled ? createTapped : null,
          ),
        ),
      ],
    );
  }
}
