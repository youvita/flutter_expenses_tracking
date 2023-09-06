class ReportList{
  final DateTime? dateFilter;
  final double totalExpense;
  final double totalIncome;

  const ReportList({
    this.dateFilter,
    this.totalExpense = 0.0,
    this.totalIncome = 0.0
  });
}