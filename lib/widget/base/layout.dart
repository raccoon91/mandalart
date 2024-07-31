import 'package:flutter/material.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:provider/provider.dart';

class Layout extends StatefulWidget {
  final String? title;
  final bool showFloatingAction;
  final Widget? bottomNavigationBar;
  final Widget body;

  const Layout({
    super.key,
    this.title,
    required this.body,
    this.showFloatingAction = true,
    this.bottomNavigationBar,
  });

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  modeTapped() {
    Provider.of<HomeProvider>(
      context,
      listen: false,
    ).changeMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.title == null
          ? null
          : AppBar(
              centerTitle: true,
              backgroundColor: ColorClass.white,
              title: Text(
                widget.title ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
      backgroundColor: ColorClass.white,
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: widget.showFloatingAction ? Offset.zero : const Offset(0, 3),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: widget.showFloatingAction ? 1 : 0,
          child: FloatingActionButton(
            mini: true,
            shape: const CircleBorder(),
            backgroundColor: ColorClass.blue,
            onPressed: modeTapped,
            child: Consumer<HomeProvider>(
              builder: (context, state, child) {
                if (state.mode == "minimize") {
                  return const Icon(Icons.fullscreen_exit);
                }
                return const Icon(Icons.fullscreen);
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: widget.body,
        ),
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
