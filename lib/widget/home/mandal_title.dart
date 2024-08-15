import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MandalTitle extends StatefulWidget {
  final bool? showClose;
  final String? visionName;
  final String? goalName;

  const MandalTitle({
    super.key,
    this.showClose,
    this.visionName,
    this.goalName,
  });

  @override
  State<MandalTitle> createState() => _MandalTitleState();
}

class _MandalTitleState extends State<MandalTitle> {
  closeTapped() {
    if (context.canPop()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Text(
                '${widget.visionName?.split('\n')[0]}',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ...(widget.goalName != null
                  ? [
                      const Icon(Icons.chevron_right),
                      Text(
                        '${widget.goalName?.split('\n')[0]}',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]
                  : []),
            ],
          ),
          ...(widget.showClose == true
              ? [
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: closeTapped,
                      child: Center(
                        child: Icon(
                          Icons.close,
                          size: 30.w,
                        ),
                      ),
                    ),
                  ),
                ]
              : [])
        ],
      ),
    );
  }
}
