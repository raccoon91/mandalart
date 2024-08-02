import 'package:flutter/material.dart';
import 'package:mandalart/provider/plan_provider.dart';
import 'package:mandalart/widget/home/detailed_mandalart_widget.dart';
import 'package:provider/provider.dart';

class PlanScreen extends StatefulWidget {
  final String? planId;

  const PlanScreen({
    super.key,
    this.planId,
  });

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPlan();
    });
  }

  Future<void> getPlan() async {
    await Provider.of<PlanProvider>(
      context,
      listen: false,
    ).getPlanWithDetailedPlans(widget.planId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<PlanProvider>(
        builder: (context, state, child) {
          if (state.isEmpty) {
            return const Center(
              child: Text("계획을 설정하세요"),
            );
          }

          return DetailedMandalartWidget(
            type: "plan",
            plan: state.plan,
          );
        },
      ),
    );
  }
}
