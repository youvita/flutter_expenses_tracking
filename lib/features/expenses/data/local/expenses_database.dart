
import 'package:sqflite/sqflite.dart';

class ExpensesDatabase {
  static const table = 'tbExpenses';
  static const columnID = 'id';
  static const columnExpenseType = 'expense_type';
  static const columnIssueDate = 'issue_date';
  static const columnCategory = 'category';
  static const columnCurrency = 'currency';
  static const columnAmount = 'amount';

  late Database _db;

  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE $table (
        $columnID INTEGER PRIMARY KEY autoincrement,
        $columnExpenseType TEXT NOT NULL,
        $columnIssueDate TEXT NOT NULL,
        $columnCategory TEXT NOT NULL,
        $columnCurrency TEXT NOT NULL,
        $columnAmount TEXT NOT NULL
      )
    ''');
  }
}