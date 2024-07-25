import 'package:isar/isar.dart';
import 'package:mandalart/schema/sub_target_schema.dart';

part 'main_target_schema.g.dart';

@collection
class MainTarget {
  Id id = Isar.autoIncrement;

  String? name;

  int? color;

  final subTargets = IsarLinks<SubTarget>();
}
