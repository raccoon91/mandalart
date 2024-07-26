import 'package:flutter/material.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/theme/color.dart';

class ProjectWidget extends StatelessWidget {
  final ProjectModel project;

  const ProjectWidget({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: ColorClass.red,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              project.name ?? "",
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
