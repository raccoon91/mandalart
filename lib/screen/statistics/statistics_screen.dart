import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/widget/base/banner_ad.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      body: Column(
        children: [
          const BannerAD(),
          Text(
            '통계',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
