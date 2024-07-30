import 'package:flutter/material.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:provider/provider.dart';

class Layout extends StatefulWidget {
  final String? title;
  final Widget body;
  final Widget? bottomNavigationBar;

  const Layout({
    super.key,
    this.title,
    required this.body,
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
      floatingActionButton: FloatingActionButton(
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
