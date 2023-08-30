import 'dart:ffi';

import 'package:expenses_tracking/db/expenses_database.dart';

class Expenses {

  final String? expenseType;
  final String? issueDate;
  final String? category;
  final String? currency;
  final String? amount;

  const Expenses({
    this.expenseType,
    this.issueDate,
    this.category,
    this.currency,
    this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      ExpensesDatabase.columnExpenseType: expenseType,
      ExpensesDatabase.columnIssueDate: issueDate,
      ExpensesDatabase.columnCategory: category,
      ExpensesDatabase.columnCurrency: currency,
      ExpensesDatabase.columnAmount: amount,
    };
  }

  @override
  String toString() {
    return 'Expenses{expenseType: $expenseType, issueDate: $issueDate, category: $category, currency: $currency, amount: $amount}';
  }
}