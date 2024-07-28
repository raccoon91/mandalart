import 'package:flutter/material.dart';
import 'package:mandalart/model/mandal_model.dart';
import 'package:mandalart/widget/home/empty_target_widget.dart';

class MandalWidget extends StatelessWidget {
  final MandalModel? mandal;
  final void Function()? onTapEmpty;

  const MandalWidget({
    super.key,
    this.mandal,
    this.onTapEmpty,
  });

  @override
  Widget build(BuildContext context) {
    if (mandal == null || mandal?.name == null) {
      return EmptyTargetWidget(
        onTap: (mandal?.type == "mainTarget" && onTapEmpty != null)
            ? onTapEmpty
            : null,
      );
    }

    return Flexible(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: mandal?.color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              mandal?.name ?? "",
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
