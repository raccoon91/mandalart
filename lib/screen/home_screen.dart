import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/widget/home/mandalart.dart';
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
    ).getMandalProject();

    if (mounted && isEmpty) {
      context.go('/project');
    }

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<HomeProvider>(
        builder: (context, state, child) {
          if (state.isEmpty) {
            return const Center(
              child: Text("목표를 설정하세요"),
            );
          }

          return Mandalart(
            project: state.project,
            plans: state.plans,
          );
        },
      ),
    );
  }
}
