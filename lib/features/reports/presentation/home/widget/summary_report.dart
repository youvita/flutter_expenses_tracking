import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/widgets/dropdown/list_drop_down.dart';
import 'package:expenses_tracking/widgets/dropdown/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/report_list_bloc.dart';

class SummaryReport extends StatefulWidget {
  final Function callback;
  const SummaryReport({super.key, required this.callback});

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
      // height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding:const EdgeInsets.all(10),child: _YearDrop(onSelected: (value) => widget.callback(value)),),
          const SizedBox(height: 10),
          const Padding(padding: EdgeInsets.only(left: 20,right: 20), child: Column(children: [
            _ExpenseRow(),
            SizedBox(height: 10,),
            _IncomeRow()
          ],),),
          const SizedBox(height: 30,),
          SizedBox(width: double.infinity, child: SvgPicture.asset("assets/images/dos.svg",fit: BoxFit.fitWidth, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),),),
          const Padding(padding: EdgeInsets.all(20), child: _BalanceRow(),),
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
              context.read<ReportListBloc>().add(IncreaseIncome(date.year.toDouble()));
              widget.onSelected(date);
            }));
  }
}

class _ExpenseRow extends StatelessWidget {
  const _ExpenseRow({super.key});

  @override
  Widget build(BuildContext context) {
    double? expense = context.select((ReportListBloc bloc) => bloc.state.totalExpense);
    expense??=12.0;
    return Row(children: [
      const Row(children: [CircleAvatar(radius: 8, backgroundColor: MyColors.red,),SizedBox(width: 10,), Text("Expense", style: MyTextStyles.textStyleMedium17)],),
      const Spacer(),
      Text('\$${expense.toStringAsFixed(2)}', style: MyTextStyles.textStyleMedium17Red),
    ],);
  }
}

class _IncomeRow extends StatelessWidget {
  const _IncomeRow({super.key});

  @override
  Widget build(BuildContext context) {
    double? income = context.select((ReportListBloc bloc) => bloc.state.totalIncome);
    income??=40.0;
    return Row(children: [
      Row(children: [const CircleAvatar(radius: 8, backgroundColor: MyColors.green,),const SizedBox(width: 10,), Text("Income".tr(), style: MyTextStyles.textStyleMedium17)],),
      const Spacer(),
      Text( '\$${income.toStringAsFixed(2)}', style: MyTextStyles.textStyleMedium17Green),
    ],);
  }
}


class _BalanceRow extends StatelessWidget {
  const _BalanceRow({super.key});

  @override
  Widget build(BuildContext context) {
    double? income = context.select((ReportListBloc bloc) => bloc.state.totalIncome);
    income??=28.0;
    return Row(children: [
      Text("Balance".tr(), style: MyTextStyles.textStyle26,),
      const Spacer(),
      Text( '\$${income.toStringAsFixed(2)}', style: MyTextStyles.textStyleBold26Blue),
    ],);
  }
}
