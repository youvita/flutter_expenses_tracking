part of 'report_list_bloc.dart';

class ReportListState extends Equatable {
  const ReportListState({
    this.datePicker,
  });

  ReportListState copyWith({
    DateTime? datePicker,
  }) {
    return ReportListState(
      datePicker: datePicker ?? this.datePicker,
    );
  }


  final DateTime? datePicker;

  getMonthTap(){
    List<Widget> list = [];
    var listOfMonth = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    for (var element in listOfMonth) {
      list.add(Tab(text: element));
    }

    return list;
  }

  @override
  List<Object?> get props => [datePicker];
}

class CreateExpenseInitial extends ReportListState {}
