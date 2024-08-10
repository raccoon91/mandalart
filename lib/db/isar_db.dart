import 'package:isar/isar.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/project_schema.dart';
import 'package:mandalart/schema/task_schema.dart';
import 'package:path_provider/path_provider.dart';

class IsarDB {
  static late Isar isar;

  Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      name: 'mandalart',
      [ProjectSchema, PlanSchema, DetailedPlanSchema, TaskSchema],
      directory: dir.path,
    );

    return isar;
  }
}
