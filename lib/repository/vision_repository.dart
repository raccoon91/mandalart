import 'package:flutter/material.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/vision_model.dart';
import 'package:mandalart/repository/repository.dart';
import 'package:mandalart/schema/vision_schema.dart';

class VisionRepository extends Repository<Vision> {
  VisionRepository() : super(db: IsarDB.isar.visions);

  Future<VisionModel?> getVision() async {
    try {
      final visionSchema = await findOne((query) {
        return query.inProgressEqualTo(true).isDeleteEqualTo(false);
      });

      if (visionSchema == null) return null;

      final vision = VisionModel.fromSchema(visionSchema);

      return vision;
    } catch (error) {
      rethrow;
    }
  }

  Future<Vision> createVision(String name, Color color) async {
    try {
      int colorValue = color.value;

      final visionSchema = Vision()
        ..name = name
        ..color = colorValue
        ..inProgress = true;

      await IsarDB.isar.writeTxn(() async {
        await putOne(visionSchema);
      });

      return visionSchema;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteVision(int? visionId) async {
    try {
      if (visionId == null) return false;

      await IsarDB.isar.writeTxn(() async {
        await deleteOne(visionId);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
