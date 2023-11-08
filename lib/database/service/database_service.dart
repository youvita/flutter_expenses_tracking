import 'package:expenses_tracking/database/repo/expenses_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService{
  static Database? _database;

  Future<Database> get database async {
    if(_database != null){
      return _database!;
    }
    _database = await initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    WidgetsFlutterBinding.ensureInitialized();
    const name = 'expenses.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 2,
      onCreate: create
      );
      return database;
  }

  Future create(Database database, int version) async {
    // await LedgerDb().createTable(database);
    // await AccountDb().createTable(database);
    // await CategoryDb().createTable(database);
    await ExpensesDb().createTable(database);
    // await AccountDb().create(obj: Account(name: 'Cash', type: 'Cash', description: 'Cash'));
  }
}