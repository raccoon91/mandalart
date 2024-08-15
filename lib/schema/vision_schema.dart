import 'package:isar/isar.dart';
import 'package:mandalart/schema/goal_schema.dart';

part 'vision_schema.g.dart';

@collection
class Vision {
  Id id = Isar.autoIncrement;

  bool inProgress = false;

  late String name;

  String? description;

  int? color;

  String? style;

  bool isDelete = false;

  final goals = IsarLinks<Goal>();
}
