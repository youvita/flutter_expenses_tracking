
import 'package:easy_localization/easy_localization.dart';

import '../../config/utils.dart';

class Expenses {
  int? _id;
  String? _statusType;
  String? _issueDate;
  String? _createDate;
  String? _categoryImage;
  String? _category;
  String? _currencyCode;
  String? _amount;
  String? _remark;
  bool? _isUpdate;
  bool? _isNew;

  Expenses(this._id, this._statusType, this._issueDate, this._createDate, this._categoryImage, this._category, this._currencyCode, this._amount, this._remark);

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'status_type': _statusType,
      'issue_datetime': _issueDate ?? DateFormat('yyyyMMddHHmmss').format(DateTime.now()),
      'create_datetime': _createDate = DateFormat('yyyyMMddHHmmss').format(DateTime.now()),
      'category_image': _categoryImage ?? Utils().getUnicodeCharacter("2753"),
      'category': _category ?? 'N/A',
      'currency_code': _currencyCode ?? 'USD',
      'amount': _amount ?? '0',
      'remark': _remark ?? ''
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
  String? get createDate => _createDate;
  String? get categoryImage => _categoryImage;
  String? get category => _category;
  String? get currencyCode => _currencyCode;
  String? get amount => _amount;
  String? get remark => _remark;
  bool? get isUpdate => _isUpdate;
  bool? get isNew => _isNew;

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
    _amount = value;
  }

  set remarkChanged(String? value) {
    _remark = value;
  }

  set updateChanged(bool? value) {
    _isUpdate = value;
  }

  set newChanged(bool? value) {
    _isNew = value;
  }

}