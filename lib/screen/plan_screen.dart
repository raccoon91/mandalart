import 'package:flutter/material.dart';
import 'package:mandalart/provider/plan_provider.dart';
import 'package:mandalart/widget/home/detailed_mandalart_widget.dart';
import 'package:mandalart/widget/layout/mandal_layout.dart';
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
    return Consumer<PlanProvider>(
      builder: (context, state, child) => MandalLayout(
          isEmpty: state.isEmpty,
          emptyMessage: '계획을 설정하세요',
          title: Row(
            children: [
              Text(
                '${state.proejctName}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(Icons.chevron_right),
              Text(
                '${state.plan?.name}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          body: DetailedMandalartWidget(
            type: 'plan',
            plan: state.plan,
          )),
    );
  }
}
