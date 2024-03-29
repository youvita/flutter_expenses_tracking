import '../../../../core/db/expenses_database.dart';

class Expenses {
  final int? id;
  final String? statusType;
  final String? issueDate;
  final String? createDate;
  final String? categoryImage;
  final String? category;
  final String? currencyCode;
  final String? amount;
  final String? remark;

  const Expenses({
    this.id,
    this.statusType,
    this.issueDate,
    this.createDate,
    this.categoryImage,
    this.category,
    this.currencyCode,
    this.amount,
    this.remark
  });

  Map<String, dynamic> toMap() {
    return {
      ExpensesDatabase.columnID: id,
      ExpensesDatabase.columnStatusType: statusType,
      ExpensesDatabase.columnIssueDate: issueDate,
      ExpensesDatabase.columnCreateDate: createDate,
      ExpensesDatabase.columnCategoryImage: categoryImage,
      ExpensesDatabase.columnCategory: category,
      ExpensesDatabase.columnCurrency: currencyCode,
      ExpensesDatabase.columnAmount: amount,
      ExpensesDatabase.columnRemark: remark
    };
  }

  @override
  String toString() {
    return 'Expenses { '
        'id: $id, '
        'statusType: $statusType, '
        'issueDate: $issueDate, '
        'createDate: $createDate, '
        'categoryImage: $categoryImage, '
        'category: $category, '
        'currencyCode: $currencyCode, '
        'amount: $amount, '
        'remark: $remark'
        '}';
  }
}