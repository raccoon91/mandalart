import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/db/seed.dart';
import 'package:mandalart/schema/app_info.dart';
import 'package:mandalart/schema/complete_schema.dart';
import 'package:mandalart/schema/goal_schema.dart';
import 'package:mandalart/schema/goal_template_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/plan_template_schema.dart';
import 'package:mandalart/schema/schedule_schema.dart';
import 'package:mandalart/schema/vision_schema.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class IsarDB {
  static late Isar isar;

  Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      name: 'mandalart',
      [
        AppInfoSchema,
        GoalTemplateSchema,
        PlanTemplateSchema,
        VisionSchema,
        GoalSchema,
        PlanSchema,
        ScheduleSchema,
        CompleteSchema,
      ],
      directory: dir.path,
    );

    await onCreate();

    return isar;
  }

  Future<void> onCreate() async {
    try {
      List<AppInfo>? infos = await isar.appInfos.where().findAll();

      var info = infos.lastOrNull;

      debugPrint('database version ${info?.version ?? 'None'}');

      if (info == null) {
        await initDatabase();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> initDatabase() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appVersion = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    await isar.writeTxn(() async {
      for (var goal in goals) {
        var goalSeed = GoalTemplate()
          ..name = goal['name']
          ..color = goal['color'];

        await isar.goalTemplates.put(goalSeed);

        var items = goal['items'] ?? [];

        for (var item in items) {
          var planSeed = PlanTemplate()
            ..name = item['name']
            ..color = item['color'];

          await isar.planTemplates.put(planSeed);

          goalSeed.planTemplates.add(planSeed);
        }

        await goalSeed.planTemplates.save();
      }

      var appInfo = AppInfo()
        ..version = '1'
        ..appVersion = appVersion
        ..buildNumber = buildNumber;

      await isar.appInfos.put(appInfo);
    });

    debugPrint('initialize database');
  }
}
