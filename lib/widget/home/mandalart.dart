import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/main_target_model.dart';
import 'package:mandalart/model/mandal_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/widget/home/mandal_widget.dart';

class Mandalart extends StatefulWidget {
  final ProjectModel? project;
  final List<MainTargetModel>? mainTargets;

  const Mandalart({
    super.key,
    this.project,
    this.mainTargets,
  });

  @override
  State<Mandalart> createState() => _MandalartState();
}

class _MandalartState extends State<Mandalart> {
  void Function() goToMainTargetCreateScreen(int? mainTargetId) {
    return () {
      if (widget.project?.id == null || mainTargetId == null) return;

      context.push(
        "/main-target/create?projectId=${widget.project?.id}&mainTargetId=$mainTargetId",
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(3, (index) {
            return MandalWidget(
              mandal: MandalModel.fromJson(
                "mainTarget",
                widget.mainTargets?[index],
              ),
              onTapEmpty: goToMainTargetCreateScreen(
                widget.mainTargets?[index].id,
              ),
            );
          }),
        ),
        Row(
          children: [
            MandalWidget(
              mandal: MandalModel.fromJson(
                "mainTarget",
                widget.mainTargets?[3],
              ),
              onTapEmpty: goToMainTargetCreateScreen(
                widget.mainTargets?[3].id,
              ),
            ),
            MandalWidget(
              mandal: MandalModel.fromJson(
                "mainTarget",
                widget.project,
              ),
              onTapEmpty: goToMainTargetCreateScreen(
                widget.project?.id,
              ),
            ),
            MandalWidget(
              mandal: MandalModel.fromJson(
                "mainTarget",
                widget.mainTargets?[4],
              ),
              onTapEmpty: goToMainTargetCreateScreen(
                widget.mainTargets?[4].id,
              ),
            ),
          ],
        ),
        Row(
          children: List.generate(3, (index) {
            return MandalWidget(
              mandal: MandalModel.fromJson(
                "mainTarget",
                widget.mainTargets?[index + 5],
              ),
              onTapEmpty: goToMainTargetCreateScreen(
                widget.mainTargets?[index + 5].id,
              ),
            );
          }),
        ),
      ],
    );
  }
}
