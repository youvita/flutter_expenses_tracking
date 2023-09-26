import 'package:expenses_tracking/database/models/expenses.dart';

class GlobalVariables {
  static final GlobalVariables _instance = GlobalVariables._internal();

  factory GlobalVariables() => _instance;
  GlobalVariables._internal();

  static String? category;
  String? get categoryImage => Expenses.categoryImage;
}