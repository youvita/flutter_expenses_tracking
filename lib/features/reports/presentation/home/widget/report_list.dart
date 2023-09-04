import 'package:expenses_tracking/constand/constand.dart';
import 'package:expenses_tracking/features/reports/presentation/home/bloc/report_list_bloc.dart';
import 'package:expenses_tracking/widgets/toggle_swich.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ReportList extends StatelessWidget {
  const ReportList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportListBloc, ReportListState>(
        builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 20,),
          Center(child: ExpenseToggle(onToggle: (){},),)
        //  _HeaderCalendar(),
        ],
      );
    });
  }
}

class _HeaderCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportListBloc, ReportListState>(
        builder: (context, state) {
      return Container(
        width: double.infinity,
        height: 100,
        color: Colors.blue,
        child: Column(
          children: [],
        ),
      );
    });
  }
}
