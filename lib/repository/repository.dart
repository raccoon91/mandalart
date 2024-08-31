import 'package:isar/isar.dart';

class Repository<T> {
  final IsarCollection<T> db;

  const Repository({
    required this.db,
  });

  Future<int> getSize() async {
    try {
      var size = await db.getSize(includeIndexes: true, includeLinks: true);

      return size;
    } catch (error) {
      rethrow;
    }
  }

  Future<T?> findOne(FilterQuery<T> builder) async {
    try {
      var schema = await db.where().filter().group(builder).findFirst();

      return schema;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<T>> findAll(FilterQuery<T> builder) async {
    try {
      var schemaList = await db.where().filter().group(builder).findAll();

      return schemaList;
    } catch (error) {
      rethrow;
    }
  }

  Future<int> putOne(T schema) async {
    try {
      var id = await db.put(schema);

      return id;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<int>> putAll(List<T> schemaList) async {
    try {
      var ids = await db.putAll(schemaList);

      return ids;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteOne(int id) async {
    try {
      var bool = await db.delete(id);

      return bool;
    } catch (error) {
      rethrow;
    }
  }

  Future<int> deleteAll(List<int> ids) async {
    try {
      var count = await db.deleteAll(ids);

      return count;
    } catch (error) {
      rethrow;
    }
  }
}