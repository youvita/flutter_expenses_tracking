part of 'report_list_bloc.dart';

class ReportListState extends Equatable {
  const ReportListState({
    this.statusType,
    this.issueDate,
    this.categoryImage,
    this.category,
    this.currencyCode,
    this.amount,
    this.remark
  });

  ReportListState copyWith({
    String? statusType,
    DateTime? issueDate,
    String? categoryImage,
    String? category,
    String? currencyCode,
    double? amount,
    String? remark
  }) {
    return ReportListState(
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

class CreateExpenseInitial extends ReportListState {}
