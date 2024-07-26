import 'package:flutter/material.dart';
import 'package:mandalart/theme/color.dart';

class EmptyTargetWidget extends StatelessWidget {
  const EmptyTargetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorClass.gray,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.add,
            size: 20,
            color: ColorClass.gray,
          ),
        ),
      ),
    );
  }
}
