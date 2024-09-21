import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:provider/provider.dart';

class FloatingButton extends StatelessWidget {
  final bool show;
  final void Function()? onPressed;

  const FloatingButton({
    super.key,
    required this.show,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: show ? Offset.zero : Offset(0, 3.h),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: show ? 1 : 0,
        child: FloatingActionButton(
          mini: true,
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
