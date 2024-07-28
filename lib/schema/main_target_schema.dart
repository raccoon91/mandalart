import 'package:isar/isar.dart';

part 'main_target_schema.g.dart';

@collection
class MainTarget {
  Id id = Isar.autoIncrement;

  late int projectId;

  String? name;

  int? color;

  bool delete = false;
}
