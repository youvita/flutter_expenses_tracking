part of 'create_expense_bloc.dart';

class CreateExpenseState extends Equatable {
  const CreateExpenseState({
    this.statusType,
    this.issueDate,
    this.categoryImage,
    this.category,
    this.currencyCode,
    this.amount,
    this.remark
  });

  CreateExpenseState copyWith({
    String? statusType,
    DateTime? issueDate,
    String? categoryImage,
    String? category,
    String? currencyCode,
    double? amount,
    String? remark
  }) {
    return CreateExpenseState(
      statusType: statusType ?? this.statusType,
      issueDate: issueDate ?? this.issueDate,
      categoryImage: categoryImage ?? this.categoryImage,
      category: category ?? this.category,
      currencyCode: currencyCode ?? this.currencyCode,
      amount: amount ?? this.amount,
      remark: remark ?? this.remark
    );
  }

  final String? statusType;
  final DateTime? issueDate;
  final String? categoryImage;
  final String? category;
  final String? currencyCode;
  final double? amount;
  final String? remark;

  @override
  List<Object?> get props => [statusType, issueDate, categoryImage, category, currencyCode, amount, remark];
}

class CreateExpenseInitial extends CreateExpenseState {}
