import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SettingItem extends StatefulWidget {
  final String? to;
  final IconData icon;
  final String? name;
  final Widget? child;
  final void Function()? onTap;

  const SettingItem({
    super.key,
    this.to,
    required this.icon,
    this.name,
    this.child,
    this.onTap,
  });

  @override
  State<SettingItem> createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  onTapMove() {
    if (widget.to == null) return;

    context.push(widget.to!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.to != null ? onTapMove : widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
        child: Row(
          children: [
            Icon(widget.icon),
            SizedBox(width: 10.w),
            widget.child != null
                ? Expanded(child: widget.child!)
                : Text(
                    widget.name ?? "",
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
