import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constand/constand.dart';
import 'package:expenses_tracking/widgets/dropdown/list_drop_down.dart';
import 'package:expenses_tracking/widgets/dropdown/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/report_list_bloc.dart';

class SummaryReport extends StatefulWidget {
  const SummaryReport({super.key});

  @override
  State<SummaryReport> createState() => _SummaryReportState();
}

class _SummaryReportState extends State<SummaryReport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _YearDrop(onSelected: (){}),
          const _ExpenseRow(),
          const _IncomeRow(),
      ],),
    );
  }
}


class _YearDrop extends StatefulWidget {
  final Function onSelected;

  const _YearDrop({Key? key, required this.onSelected}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YearDropDown();
}

class _YearDropDown extends State<_YearDrop> {
  List<ListItem<String>> dropDownList = [];
  int currentYear = DateTime.now().year;
  String selectedValue = DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    dropDownList=[];
    selectedValue = Utils.dateFormatYYYY(DateTime.now());
    currentYear = DateTime.now().year;
    for (int i = currentYear - 5; i <= currentYear; i++) {
      dropDownList.add(ListItem<String>(i.toString(), value: i.toString()));
    }

    return DropDownList<String>(
            listItems: dropDownList,
            value: selectedValue,
            textStyle: MyTextStyles.textStyleBold20,
            onChange: (value) => setState(() {
              selectedValue = value!;
              DateTime date = DateTime.parse("$selectedValue-01-01");
              context.read<ReportListBloc>().add(OnYearDropChange(date));
            }));
  }
}

class _ExpenseRow extends StatelessWidget {
  const _ExpenseRow({super.key});

  @override
  Widget build(BuildContext context) {
    String expense = context.read<ReportListBloc>().state.totalExpense.toStringAsFixed(2);
    return Row(children: [
      const Text("Expense", style: MyTextStyles.textStyleNormal15),
      const Spacer(),
      Text(expense, style: MyTextStyles.textStyleNormal15),
    ],);
  }
}

class _IncomeRow extends StatelessWidget {
  const _IncomeRow({super.key});

  @override
  Widget build(BuildContext context) {
    String income = context.select((ReportListBloc bloc) => bloc.state.totalIncome.toStringAsFixed(2));
    int a = 0;
    return Row(children: [
      const Text("Income", style: MyTextStyles.textStyleNormal15),
      const Spacer(),
      Text(income, style: MyTextStyles.textStyleNormal15),
    ],);
  }
}

