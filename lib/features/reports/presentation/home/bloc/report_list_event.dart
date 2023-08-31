part of 'report_list_bloc.dart';

abstract class ReportListEvent extends Equatable {
  const ReportListEvent();

  @override
  List<Object> get props => [];
}


class SaveEvent extends ReportListEvent {
  const SaveEvent();
}

class OnDatePickerChanged extends ReportListEvent {
  const OnDatePickerChanged(this.datePicker);

  final DateTime datePicker;

  //function
  Future<DateTime> onDatePickerChanged(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: datePicker,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != datePicker) {
      return picked;
    } else {
      return datePicker;
    }
  }

  @override
  List<Object> get props => [datePicker, onDatePickerChanged];


}