import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';
import 'package:provider/provider.dart';

class SettingStorageScreen extends StatefulWidget {
  const SettingStorageScreen({super.key});

  @override
  State<SettingStorageScreen> createState() => _SettingStorageScreenState();
}

class _SettingStorageScreenState extends State<SettingStorageScreen> {
  onTapClean() async {
    bool success = await Provider.of<HomeProvider>(
      context,
      listen: false,
    ).deleteMandalProject();

    if (!mounted || !success) return;

    context.go('/project');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: '저장공간',
      body: Padding(
        padding: EdgeInsets.only(top: 60.h, right: 20.w, left: 20.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: ColorClass.under,
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onTapClean,
                child: Row(
                  children: [
                    const Icon(Icons.cleaning_services),
                    SizedBox(width: 10.w),
                    Text(
                      '데이터 삭제',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
