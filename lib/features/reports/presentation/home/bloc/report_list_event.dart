part of 'report_list_bloc.dart';

abstract class ReportListEvent extends Equatable {
  const ReportListEvent();

  @override
  List<Object> get props => [];
}


class SaveEvent extends ReportListEvent {
  const SaveEvent();
}

class OnYearDropChange extends ReportListEvent {
  const OnYearDropChange(this.datePicker);
  final DateTime datePicker;

  @override
  List<Object> get props => [datePicker];
}