import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/widget/base/banner_ad.dart';

class MandalLayout extends StatelessWidget {
  final bool? isEmpty;
  final String? emptyMessage;
  final Widget? title;
  final Widget body;

  const MandalLayout({
    super.key,
    this.isEmpty,
    this.emptyMessage,
    this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    if (isEmpty == true && emptyMessage != null) {
      return Center(
        child: Text(
          emptyMessage ?? "",
          style: TextStyle(
            fontSize: 24.sp,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Column(
        children: [
          const BannerAD(),
          SizedBox(height: 20.h),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                ...(title != null
                    ? [
                        title!,
                        SizedBox(height: 20.h),
                      ]
                    : []),
                body,
                SizedBox(height: 10.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}
