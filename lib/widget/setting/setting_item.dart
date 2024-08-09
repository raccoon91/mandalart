import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SettingItem extends StatefulWidget {
  final String name;
  final String? to;

  const SettingItem({
    super.key,
    required this.name,
    this.to,
  });

  @override
  State<SettingItem> createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  onTapItem() {
    if (widget.to == null) return;

    context.push(widget.to!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.to == null ? null : onTapItem,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 24.w,
        ),
        child: Row(
          children: [
            const Icon(Icons.storage),
            SizedBox(width: 10.w),
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
