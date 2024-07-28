import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/mandal_model.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/widget/home/mandal_widget.dart';

class Mandalart extends StatefulWidget {
  final ProjectModel? project;
  final List<PlanModel>? plans;

  const Mandalart({
    super.key,
    this.project,
    this.plans,
  });

  @override
  State<Mandalart> createState() => _MandalartState();
}

class _MandalartState extends State<Mandalart> {
  void Function() goToPlanCreateScreen(int? planId) {
    return () {
      if (widget.project?.id == null || planId == null) return;

      context.push(
        "/main-target/create?projectId=${widget.project?.id}&planId=$planId",
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
                "plan",
                widget.plans?[index],
              ),
              onTapEmpty: goToPlanCreateScreen(
                widget.plans?[index].id,
              ),
            );
          }),
        ),
        Row(
          children: [
            MandalWidget(
              mandal: MandalModel.fromJson(
                "plan",
                widget.plans?[3],
              ),
              onTapEmpty: goToPlanCreateScreen(
                widget.plans?[3].id,
              ),
            ),
            MandalWidget(
              mandal: MandalModel.fromJson(
                "plan",
                widget.project,
              ),
              onTapEmpty: goToPlanCreateScreen(
                widget.project?.id,
              ),
            ),
            MandalWidget(
              mandal: MandalModel.fromJson(
                "plan",
                widget.plans?[4],
              ),
              onTapEmpty: goToPlanCreateScreen(
                widget.plans?[4].id,
              ),
            ),
          ],
        ),
        Row(
          children: List.generate(3, (index) {
            return MandalWidget(
              mandal: MandalModel.fromJson(
                "plan",
                widget.plans?[index + 5],
              ),
              onTapEmpty: goToPlanCreateScreen(
                widget.plans?[index + 5].id,
              ),
            );
          }),
        ),
      ],
    );
  }
}
