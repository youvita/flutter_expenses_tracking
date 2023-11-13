import 'package:expenses_tracking/config/setting_utils.dart';
import 'package:expenses_tracking/database/models/category_popular.dart';
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
        category_default TEXT,
        currency_code TEXT,
        amount TEXT,
        remark TEXT
      )
    ''');
  }

  Future<int> delete(Expenses expenses) async {
    final db = await DatabaseService().database;
    return await db.delete(tableName, where: '_id=?', whereArgs: [expenses.id]);
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
      maps = await db.query(tableName, orderBy: 'issue_datetime DESC');
    } else {
      maps = await db.query(tableName, where: 'status_type=?', whereArgs: [status], orderBy: 'issue_datetime DESC');
    }
    return List.generate(maps.length, (index) {
      return Expenses(
          maps[index]['_id'],
          maps[index]['status_type'],
          maps[index]['issue_datetime'],
          maps[index]['create_datetime'],
          maps[index]['category_image'],
          maps[index]['category'],
          maps[index]['category_default'],
          maps[index]['currency_code'],
          maps[index]['amount'],
          maps[index]['remark']
      );
    });
  }

  Future<List<CategoryPopular>> getPopular() async {
    final db = await DatabaseService().database;
    List<Map<String, dynamic>> maps = List.empty();
    maps = await db.rawQuery('SELECT category_image, category, COUNT(*) AS popular_count FROM expenses WHERE category_default IS NULL GROUP BY category_image ORDER BY popular_count DESC');
    return List.generate(maps.length, (index) {
      return CategoryPopular(
          maps[index]['category_image'],
          maps[index]['category'],
          maps[index]['popular_count']
      );
    });
  }

  Future<double> getTotalExpensesIncome(bool isIncome,String year, String month) async {
    var statusType = isIncome ? '2' : '1';
    final db = await DatabaseService().database;
    String filter = "AND substr(create_datetime, 1, 4) = '$year'";
    if(month.isNotEmpty){
      filter = "AND substr(create_datetime, 1, 6) = '$year$month'";
    }
    var query = """
    SELECT
      max(currency_code), min(currency_code), max(status_type), min(status_type),
      coalesce(CASE
        WHEN '${Setting.currency}' = 'USD' THEN
          SUM(CASE
            WHEN currency_code = 'USD' THEN amount
            WHEN currency_code = 'KHR' THEN amount / ${Setting.exchangeRate}
          END)
        WHEN '${Setting.currency}' = 'KHR' THEN
          SUM(CASE
            WHEN currency_code = 'USD' THEN amount * ${Setting.exchangeRate}
            WHEN currency_code = 'KHR' THEN amount
          END)
      END, 0) AS amount
    FROM $tableName 
    WHERE status_type = '$statusType' 
    $filter
    """;
    var result = await db.rawQuery(query);
    var total = result[0]['amount'];
   return double.parse(total.toString());
  }
}