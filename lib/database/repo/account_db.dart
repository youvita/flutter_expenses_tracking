import 'package:expenses_tracking/database/models/account_model.dart';
import 'package:expenses_tracking/database/service/database_service.dart';
import 'package:sqflite/sqflite.dart';

class AccountDb {
  final tableName = 'account';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" integer primary key autoincrement,
      "name" string,
      "init_balance" double,
      "type" string,
      "created_at" date not null default (datetime('now')),
      "updated_at" date,
      "description" string
    );""");
  }

  //get
  Future<List<Account>> getAll() async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query(tableName, orderBy: 'date DESC');
    return List.generate(maps.length, (i) {
      return Account.map(maps[i]);
    });
  }

  //get by id
  Future<Account> get(int id) async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    return Account.map(maps[0]);
  }

  //save
  Future<int> create({required Account obj}) async {
    final db = await DatabaseService().database;
    return await db.insert(tableName, obj.toMap());
  }

  //update
  Future<int> update(Account obj) async {
    final db = await DatabaseService().database;
    return await db.update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [obj.id]);
  }

  //delete
  Future<int> delete(int id) async {
    final db = await DatabaseService().database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}