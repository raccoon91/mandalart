import 'package:flutter/material.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/detailed_empty_widget.dart';

class DetailedPlanWidget extends StatelessWidget {
  final String? name;
  final Color? color;

  const DetailedPlanWidget({
    super.key,
    this.name,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (name == null) {
      return const Flexible(
        child: DetailedEmptyWidget(),
      );
    }

    return Flexible(
      child: CardWidget(
        name: name,
        color: color,
      ),
    );
  }
}
