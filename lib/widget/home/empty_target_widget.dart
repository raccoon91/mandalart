import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/theme/color.dart';

class EmptyTargetWidget extends StatelessWidget {
  final Color? color;

  const EmptyTargetWidget({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: () {
            context.push("/main-target/create");
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: color ?? ColorClass.under,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.add,
              size: 20,
              color: ColorClass.black,
            ),
          ),
        ),
      ),
    );
  }
}
