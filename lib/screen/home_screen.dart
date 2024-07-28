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

    getProgressMandal();
  }

  Future<void> getProgressMandal() async {
    bool isEmpty = await Provider.of<HomeProvider>(
      context,
      listen: false,
    ).getMandal();

    if (mounted && isEmpty) {
      context.go('/project');
    }

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Consumer<HomeProvider>(
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text("목표를 설정하세요"),
            );
          }

          return Mandalart(
            project: value.project,
            mainTargets: value.mainTargets,
          );
        },
      ),
    );
  }
}
