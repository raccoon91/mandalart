import 'package:isar/isar.dart';
import 'package:mandalart/schema/goal_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/schedule_schema.dart';
import 'package:mandalart/schema/task_schema.dart';
import 'package:mandalart/schema/vision_schema.dart';
import 'package:path_provider/path_provider.dart';

class IsarDB {
  static late Isar isar;

  Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      name: 'mandalart',
      [VisionSchema, GoalSchema, PlanSchema, ScheduleSchema, TaskSchema],
      directory: dir.path,
    );

    return isar;
  }
}
