import 'package:expenses_tracking/database/models/ledger_model.dart';
import 'package:expenses_tracking/database/service/database_service.dart';
import 'package:sqflite/sqflite.dart';

class LedgerDb {
  final tableName = 'ledger';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" integer primary key autoincrement,
      "account_id" integer,
      "category_id" integer,
      "transaction_type" string,
      "transfer_to_id" integer,
      "amount" double,
      "currency" string,
      "exchange_rate" double,
      "note" string,
      "description" string,
      "attach" string,
      "date" date,
      "create_at" date not null default (datetime('now')),
      "updated_at" date
    );""");
  }

  //get
  Future<List<Ledger>> getAll() async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query(tableName, orderBy: 'date DESC');
    return List.generate(maps.length, (i) {
      return Ledger.map(maps[i]);
    });
  }

  //get by id
  Future<Ledger> get(int id) async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    return Ledger.map(maps[0]);
  }

  //save
  Future<int> create({required Ledger obj}) async {
    final db = await DatabaseService().database;
    return await db.insert(tableName, obj.toMap());
  }

  //update
  Future<int> update(Ledger obj) async {
    final db = await DatabaseService().database;
    return await db.update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [obj.id]);
  }

  //delete
  Future<int> delete(int id) async {
    final db = await DatabaseService().database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
