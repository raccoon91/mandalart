import 'package:flutter/material.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:provider/provider.dart';

class FloatingButton extends StatelessWidget {
  final void Function()? onPressed;

  const FloatingButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: Offset.zero,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: 1,
        child: FloatingActionButton(
          mini: true,
          shape: const CircleBorder(),
          backgroundColor: ColorClass.blue,
          onPressed: onPressed,
          child: Consumer<HomeProvider>(
            builder: (context, state, child) {
              if (state.mode == 'minimize') {
                return const Icon(Icons.fullscreen_exit);
              }
              return const Icon(Icons.fullscreen);
            },
          ),
        ),
      ),
    );
  }
}
