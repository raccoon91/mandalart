import 'package:isar/isar.dart';
import 'package:mandalart/schema/plan_schema.dart';

part 'goal_schema.g.dart';

@collection
class Goal {
  Id id = Isar.autoIncrement;

  late int visionId;

  late int order;

  String? name;

  String? description;

  int? color;

  String? style;

  bool isDelete = false;

  final plans = IsarLinks<Plan>();
}
