
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpensesDatabase {
  static const _databaseName = "expenses_database.db";
  static const _databaseVersion = 1;
  static const table = 'tbExpenses';
  static const columnID = '_id';
  static const columnStatusType = 'status_type';
  static const columnIssueDate = 'issue_datetime';
  static const columnCreateDate = 'create_datetime';
  static const columnCategoryImage = 'category_image';
  static const columnCategory = 'category';
  static const columnCurrency = 'currency_code';
  static const columnAmount = 'amount';
  static const columnRemark = 'remark';

  late Database _db;

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final path = join(await getDatabasesPath(), _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE $table (
        $columnID INTEGER PRIMARY KEY autoincrement,
        $columnStatusType TEXT,
        $columnIssueDate TEXT,
        $columnCreateDate TEXT,
        $columnCategoryImage TEXT,
        $columnCategory TEXT,
        $columnCurrency TEXT,
        $columnAmount TEXT,
        $columnRemark TEXT
      )
    ''');
  }

  // inserted row.
  Future<int> insert(Expenses expenses) async {
    return await _db.insert(table, expenses.toMap());
  }

  Future<List<Expenses>> query() async {
    final List<Map<String, dynamic>> maps = await _db.query(table);
    return List.generate(maps.length, (index) {
      return Expenses(
        statusType: maps[index][columnStatusType],
        issueDate: maps[index][columnIssueDate],
        createDate: maps[index][columnCreateDate],
        categoryImage: maps[index][columnCategoryImage],
        category: maps[index][columnCategory],
        currencyCode: maps[index][columnCurrency],
        amount: maps[index][columnAmount],
        remark: maps[index][columnRemark]
      );
    });
  }

}