import 'package:flutter/material.dart';
import 'package:mandalart/model/project_model.dart';

class ProjectWidget extends StatelessWidget {
  final ProjectModel project;
  final Color? color;

  const ProjectWidget({
    super.key,
    required this.project,
    this.color,
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
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              project.name,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
