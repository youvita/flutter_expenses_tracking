
import 'package:sqflite/sqflite.dart';

import '../models/expenses.dart';
import '../service/database_service.dart';

class ExpensesDb {

  final tableName = 'expenses';

  // Future<void> createTable(Database database) async {
  //   await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
  //     "_id" integer primary key autoincrement,
  //     "status_type" string,
  //     "issue_datetime" string,
  //     "create_datetime" string,
  //     "category_image" string,
  //     "category" string,
  //     "currency_code" string,
  //     "amount" string,
  //     "remark" string
  //   );""");
  // }

  Future createTable(Database database) async {
    await database.execute(''' 
      CREATE TABLE $tableName (
        _id INTEGER PRIMARY KEY autoincrement,
        status_type TEXT,
        issue_datetime TEXT,
        create_datetime TEXT,
        category_image TEXT,
        category TEXT,
        currency_code TEXT,
        amount TEXT,
        remark TEXT
      )
    ''');
  }

  // inserted row.
  Future<int> insert(Expenses expenses) async {
    final db = await DatabaseService().database;
    return await db.insert(tableName, expenses.toMap());
  }

}