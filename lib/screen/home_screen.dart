import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/widget/home/mandal_title.dart';
import 'package:mandalart/widget/home/mandalart_widget.dart';
import 'package:mandalart/widget/layout/mandal_layout.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProgressMandal();
    });
  }

  Future<void> getProgressMandal() async {
    bool isEmpty = await Provider.of<HomeProvider>(
      context,
      listen: false,
    ).getProjectWithPlans();

    if (mounted && isEmpty) {
      context.go('/project');
    }

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, state, child) => MandalLayout(
        isEmpty: state.isEmpty,
        emptyMessage: '목표를 설정하세요',
        title: MandalTitle(
          projectName: state.project?.name,
        ),
        body: MandalartWidget(
          mode: state.mode,
          project: state.project,
        ),
      ),
    );
  }
}
