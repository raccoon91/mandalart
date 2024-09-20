import 'package:isar/isar.dart';

part 'plan_template_schema.g.dart';

@collection
class PlanTemplate {
  Id id = Isar.autoIncrement;

  String? name;

  String? color;

  String? description;

  String? style;
}
