import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/widget/home/mandal_title.dart';
import 'package:mandalart/widget/home/mandalart_widget.dart';
import 'package:mandalart/widget/layout/floating_button.dart';
import 'package:mandalart/widget/layout/mandal_layout.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';
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
    bool isEmpty =
        await Provider.of<HomeProvider>(context, listen: false).getVision();

    if (mounted && isEmpty) {
      context.go('/vision');
    }

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      body: Consumer<HomeProvider>(
        builder: (context, state, child) => MandalLayout(
          isEmpty: state.vision == null ||
              state.vision?.goals == null ||
              state.vision?.goals?.isEmpty == true,
          emptyMessage: '목표를 설정하세요',
          title: MandalTitle(
            visionName: state.vision?.name,
          ),
          body: MandalartWidget(
            mode: state.mode,
            vision: state.vision,
          ),
        ),
      ),
      floatingActionButton: FloatingButton(
        show: true,
        onPressed: () {
          Provider.of<HomeProvider>(context, listen: false).changeMode();
        },
      ),
    );
  }
}
