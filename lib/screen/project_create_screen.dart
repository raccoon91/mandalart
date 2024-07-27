import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/base/color_picker.dart';
import 'package:mandalart/widget/base/input.dart';
import 'package:provider/provider.dart';

class ProjectCreateScreen extends StatefulWidget {
  const ProjectCreateScreen({super.key});

  @override
  State<ProjectCreateScreen> createState() => _ProjectCreateScreenState();
}

class _ProjectCreateScreenState extends State<ProjectCreateScreen> {
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
    await Provider.of<HomeProvider>(context, listen: false).createProject(
      projectController.text,
      color,
    );

    if (!mounted) return;

    context.go("/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("목표 생성"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
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
        ),
      ),
    );
  }
}