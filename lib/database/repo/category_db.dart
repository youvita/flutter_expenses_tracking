import 'package:expenses_tracking/database/models/category_model.dart';
import 'package:expenses_tracking/database/service/database_service.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDb {
  final tableName = 'category';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" integer primary key autoincrement,
      "name" string,
      "icon" string
    );""");
  }

  //get
  Future<List<Category>> getAll() async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query(tableName, orderBy: 'date DESC');
    return List.generate(maps.length, (i) {
      return Category.map(maps[i]);
    });
  }

  //save
  Future<int> create({required Category obj}) async {
    final db = await DatabaseService().database;
    return await db.insert(tableName, obj.toMap());
  }

  //update
  Future<int> update(Category obj) async {
    final db = await DatabaseService().database;
    return await db.update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [obj.id]);
  }

  //delete
  Future<int> delete(int id) async {
    final db = await DatabaseService().database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}