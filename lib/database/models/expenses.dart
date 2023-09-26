
import 'package:easy_localization/easy_localization.dart';

class Expenses {
  int? id;
  static String? statusType;
  static String? issueDate;
  static String? createDate;
  static String? categoryImage;
  static String? category;
  static String? currencyCode;
  static String? amount;
  static String? remark;
  static bool? isUpdate;
  static bool? isNew;

  Expenses();

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'status_type': statusType,
      'issue_datetime': issueDate,
      'create_datetime': createDate = DateFormat('yyyyMMddHHmmss').format(DateTime.now()),
      'category_image': categoryImage,
      'category': category,
      'currency_code': currencyCode ?? 'USD',
      'amount': amount,
      'remark': remark
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

  // String? get statusType => _statusType;
  // String? get issueDate => _issueDate;
  // String? get categoryImage => _categoryImage;
  // String? get category => _category;
  // String? get currencyCode => _currencyCode;
  // String? get amount => _amount;
  // String? get remark => _remark;

  Expenses.statusTypeChanged(String? value) {
    statusType = value ?? '1';
  }

  Expenses.issueDateChanged(DateTime? value) {
    issueDate = DateFormat('yyyyMMddHHmmss').format(value ?? DateTime.now());
  }

  Expenses.categoryImageChanged(String? value) {
    categoryImage = value;
  }

  Expenses.categoryChanged(String? value) {
    category = value;
  }

  Expenses.currencyCodeChanged(String? value) {
    currencyCode = value ?? 'USD';
  }

  Expenses.amountChanged(String? value) {
    amount = value ?? '0.0';
  }

  Expenses.remarkChanged(String? value) {
    remark = value;
  }

  Expenses.updateChanged(bool? value) {
    isUpdate = value;
  }

  Expenses.newChanged(bool? value) {
    isNew = value;
  }

}