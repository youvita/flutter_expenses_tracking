part of 'create_expense_bloc.dart';

class CreateExpenseState extends Equatable {
  const CreateExpenseState({
    this.id,
    this.statusType,
    this.issueDate,
    this.createDate,
    this.categoryImage,
    this.category,
    this.currencyCode,
    this.amount,
    this.remark,
    this.isNew,
    this.isUpdate
  });

  CreateExpenseState copyWith({
    int? id,
    String? statusType,
    DateTime? issueDate,
    DateTime? createDate,
    String? categoryImage,
    String? category,
    String? currencyCode,
    double? amount,
    String? remark,
    bool? isNew,
    bool? isUpdate
  }) {
    return CreateExpenseState(
      id: id ?? this.id,
      statusType: statusType ?? this.statusType,
      issueDate: issueDate ?? this.issueDate,
      createDate: createDate ?? this.createDate,
      categoryImage: categoryImage ?? this.categoryImage,
      category: category ?? this.category,
      currencyCode: currencyCode ?? this.currencyCode,
      amount: amount ?? this.amount,
      remark: remark ?? this.remark,
      isNew: isNew ?? this.isNew,
      isUpdate: isUpdate ?? this.isUpdate
    );
  }

  final int? id;
  final String? statusType;
  final DateTime? issueDate;
  final DateTime? createDate;
  final String? categoryImage;
  final String? category;
  final String? currencyCode;
  final double? amount;
  final String? remark;
  final bool? isNew;
  final bool? isUpdate;

  @override
  List<Object?> get props => [id, statusType, issueDate, createDate, categoryImage, category, currencyCode, amount, remark, isNew, isUpdate];
}

class CreateExpenseInitial extends CreateExpenseState {}
