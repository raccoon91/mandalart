import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/widget/base/banner_ad.dart';
import 'package:mandalart/widget/setting/setting_card.dart';
import 'package:mandalart/widget/setting/setting_item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Column(
        children: [
          const BannerAD(),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                Text(
                  '설정',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          const SingleChildScrollView(
            child: Column(
              children: [
                SettingCard(
                  children: [
                    SettingItem(
                      name: '저장공간',
                      icon: Icons.storage,
                      to: '/setting/storage',
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
