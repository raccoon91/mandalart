import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/main_target_model.dart';
import 'package:mandalart/schema/main_target_schema.dart';

class MainTargetRepository {
  MainTargetRepository();

  Future<MainTargetModel> createMainTarget(int projectId, String name) async {
    final mainTargetSchema = MainTarget()..name = name;

    await IsarDB.isar.writeTxn(() async {
      await IsarDB.isar.mainTargets.put(mainTargetSchema);
    });

    final mainTarget = MainTargetModel.fromJson(mainTargetSchema);

    return mainTarget;
  }
}
