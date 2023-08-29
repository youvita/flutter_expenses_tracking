
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
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
        $columnExpenseType TEXT NOT NULL,
        $columnIssueDate TEXT NOT NULL,
        $columnCategory TEXT NOT NULL,
        $columnCurrency TEXT NOT NULL,
        $columnAmount TEXT NOT NULL
      )
    ''');
  }

  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(table, row);
  }
}