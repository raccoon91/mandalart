import 'package:isar/isar.dart';

part 'sub_target_schema.g.dart';

@collection
class SubTarget {
  Id id = Isar.autoIncrement;

  late int mainTargetId;

  String? name;

  int? color;

  bool delete = false;
}
