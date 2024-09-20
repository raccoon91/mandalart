import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/extension/number_extension.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/provider/setting_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';
import 'package:mandalart/widget/setting/setting_card.dart';
import 'package:mandalart/widget/setting/setting_item.dart';
import 'package:provider/provider.dart';

class SettingStorageScreen extends StatefulWidget {
  const SettingStorageScreen({super.key});

  @override
  State<SettingStorageScreen> createState() => _SettingStorageScreenState();
}

class _SettingStorageScreenState extends State<SettingStorageScreen> {
  @override
  void initState() {
    super.initState();

    getSettingStorageScreenData();
  }

  getSettingStorageScreenData() {
    Provider.of<SettingProvider>(context, listen: false).getSizes();
  }

  onTapClean() async {
    bool success = await Provider.of<SettingProvider>(context, listen: false).deleteDB();

    if (!mounted || !success) return;

    Provider.of<HomeProvider>(context, listen: false).clearHome();

    context.go('/vision');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: '저장공간',
      padding: EdgeInsets.only(top: 60.h, right: 20.w, left: 20.w),
      body: Column(
        children: [
          Expanded(
            child: Consumer<SettingProvider>(
              builder: (context, state, child) => SingleChildScrollView(
                child: SettingCard(
                  children: [
                    SettingItem(
                      icon: Icons.space_dashboard,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '목표',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${state.visionSize?.toFileSize()}',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    const Divider(color: ColorClass.border),
                    SizedBox(height: 2.h),
                    SettingItem(
                      icon: Icons.playlist_add,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '계획',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${state.goalSize?.toFileSize()}',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    const Divider(color: ColorClass.border),
                    SizedBox(height: 2.h),
                    SettingItem(
                      icon: Icons.playlist_add_check,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '실행계획',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${state.planSize?.toFileSize()}',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    const Divider(color: ColorClass.border),
                    SizedBox(height: 2.h),
                    SettingItem(
                      icon: Icons.calendar_month,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '스케줄',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${state.scheduleSize?.toFileSize()}',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    const Divider(color: ColorClass.border),
                    SizedBox(height: 2.h),
                    SettingItem(
                      icon: Icons.task_alt,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '완료',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${state.completeSize?.toFileSize()}',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: onTapClean,
                    child: Column(
                      children: [
                        const Icon(Icons.cleaning_services),
                        SizedBox(height: 8.w),
                        Text(
                          '전체 삭제',
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
