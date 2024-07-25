import 'package:isar/isar.dart';
import 'package:mandalart/schema/main_target_schema.dart';
import 'package:mandalart/schema/project_schema.dart';
import 'package:mandalart/schema/sub_target_schema.dart';
import 'package:path_provider/path_provider.dart';

class IsarDB {
  static late Isar isar;

  Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ProjectSchema, MainTargetSchema, SubTargetSchema],
      directory: dir.path,
    );

    return isar;
  }
}
