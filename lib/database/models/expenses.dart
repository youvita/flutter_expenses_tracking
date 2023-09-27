
import 'package:easy_localization/easy_localization.dart';

class Expenses {
  int? _id;
  String? _statusType;
  String? _issueDate;
  String? _categoryImage;
  String? _category;
  String? _currencyCode;
  String? _amount;
  String? _remark;
  bool? isUpdate;
  bool? isNew;

  Expenses();

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'status_type': _statusType,
      'issue_datetime': _issueDate,
      'create_datetime': DateFormat('yyyyMMddHHmmss').format(DateTime.now()),
      'category_image': _categoryImage,
      'category': _category,
      'currency_code': _currencyCode ?? 'USD',
      'amount': _amount,
      'remark': _remark
    };
  }

  @override
  String toString() {
    return 'Expenses { '
        'id: $_id, '
        'statusType: $_statusType, '
        'issueDate: $_issueDate, '
        'categoryImage: $_categoryImage, '
        'category: $_category, '
        'currencyCode: $_currencyCode, '
        'amount: $_amount, '
        'remark: $_remark'
        '}';
  }

  int? get id => _id;
  String? get statusType => _statusType;
  String? get issueDate => _issueDate;
  String? get categoryImage => _categoryImage;
  String? get category => _category;
  String? get currencyCode => _currencyCode;
  String? get amount => _amount;
  String? get remark => _remark;

  set expenseIDChanged(int? value) {
    _id = value;
  }

  set statusTypeChanged(String? value) {
    _statusType = value ?? '1';
  }

  set issueDateChanged(DateTime? value) {
    _issueDate = DateFormat('yyyyMMddHHmmss').format(value ?? DateTime.now());
  }

  set categoryImageChanged(String? value) {
    _categoryImage = value;
  }

  set categoryChanged(String? value) {
    _category = value;
  }

  set currencyCodeChanged(String? value) {
    _currencyCode = value ?? 'USD';
  }

  set amountChanged(String? value) {
    _amount = value ?? '0.0';
  }

  set remarkChanged(String? value) {
    _remark = value;
  }

  set updateChanged(bool? value) {
    isUpdate = value;
  }

  set newChanged(bool? value) {
    isNew = value;
  }

}