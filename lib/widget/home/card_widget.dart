import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String? name;
  final Color? color;
  final void Function()? onTap;
  final double size;

  const CardWidget({
    super.key,
    this.name,
    this.color,
    this.onTap,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              name ?? '',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
