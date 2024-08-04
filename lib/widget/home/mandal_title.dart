import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MandalTitle extends StatefulWidget {
  final bool? showClose;
  final String? projectName;
  final String? planName;

  const MandalTitle({
    super.key,
    this.showClose,
    this.projectName,
    this.planName,
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
                '${widget.projectName?.split('\n')[0]}',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ...(widget.planName != null
                  ? [
                      const Icon(Icons.chevron_right),
                      Text(
                        '${widget.planName?.split('\n')[0]}',
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
