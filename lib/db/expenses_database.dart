
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpensesDatabase {
  static const _databaseName = "expenses_database.db";
  static const _databaseVersion = 1;
  static const table = 'tbExpenses';
  static const columnID = '_id';
  static const columnExpenseType = 'expense_type';
  static const columnIssueDate = 'issue_date';
  static const columnCategory = 'category';
  static const columnCurrency = 'currency';
  static const columnAmount = 'amount';

  late Database _db;

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final path = join(await getDatabasesPath(), _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE $table (
        $columnID INTEGER PRIMARY KEY autoincrement,
        $columnExpenseType TEXT,
        $columnIssueDate TEXT,
        $columnCategory TEXT,
        $columnCurrency TEXT,
        $columnAmount TEXT
      )
    ''');
  }

  // inserted row.
  Future<int> insert(Expenses expenses) async {
    return await _db.insert(table, expenses.toMap());
  }

}