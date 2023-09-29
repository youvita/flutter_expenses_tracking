
import 'package:sqflite/sqflite.dart';

import '../models/expenses.dart';
import '../service/database_service.dart';

class ExpensesDb {

  final tableName = 'expenses';

  Future<void> createTable(Database database) async {
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

  Future<int> update(Expenses expenses) async {
    final db = await DatabaseService().database;
    return await db.update(tableName, expenses.toMap(), where: '_id=?', whereArgs: [expenses.id]);
  }

  Future<List<Expenses>> query(String status) async {
    final db = await DatabaseService().database;
    List<Map<String, dynamic>> maps = List.empty();
    if (status.isEmpty) {
      maps = await db.query(tableName, orderBy: 'create_datetime DESC');
    } else {
      maps = await db.query(tableName, where: 'status_type=?', whereArgs: [status], orderBy: 'create_datetime DESC');
    }
    return List.generate(maps.length, (index) {
      return Expenses(
          maps[index]['_id'],
          maps[index]['status_type'],
          maps[index]['issue_datetime'],
          maps[index]['create_datetime'],
          maps[index]['category_image'],
          maps[index]['category'],
          maps[index]['currency_code'],
          maps[index]['amount'],
          maps[index]['remark']
      );
    });
  }


}