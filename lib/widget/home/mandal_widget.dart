import 'package:flutter/material.dart';
import 'package:mandalart/model/mandal_model.dart';
import 'package:mandalart/widget/home/empty_target_widget.dart';

class MandalWidget extends StatelessWidget {
  final String type;
  final dynamic data;
  final void Function()? onTapEmpty;

  const MandalWidget({
    super.key,
    required this.type,
    this.data,
    this.onTapEmpty,
  });

  @override
  Widget build(BuildContext context) {
    MandalModel? mandal =
        data == null ? null : MandalModel.fromJson(type, data);

    if (mandal == null || mandal.name == null) {
      return EmptyTargetWidget(onTap: onTapEmpty);
    }

    return Flexible(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: mandal.color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              mandal.name ?? "",
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
