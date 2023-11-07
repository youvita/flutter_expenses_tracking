import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/config/setting_utils.dart';
import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/widgets/dropdown/list_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widgets/dropdown/list_item.dart';

class SummaryReport extends StatefulWidget {
  final double income;
  final double expenses;
  final Function callback;
  const SummaryReport({super.key,required this.income, required this.expenses, required this.callback});

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
          Padding(padding: const EdgeInsets.only(left: 20,right: 20), child: Column(children: [
            _ExpenseRow(expenses: widget.expenses,),
            const SizedBox(height: 10,),
            _IncomeRow(income: widget.income,)
          ],),),
          const SizedBox(height: 30,),
          SizedBox(width: double.infinity, child: SvgPicture.asset("assets/images/dos.svg",fit: BoxFit.fitWidth, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),),),
          Padding(padding: const EdgeInsets.all(20), child: _BalanceRow(balance: widget.income - widget.expenses,),),
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
    selectedValue = Utils.dateFormatYear(DateTime.now());
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
           
              widget.onSelected(date);
            }));
  }
}

class _ExpenseRow extends StatelessWidget {
  final double expenses;
  const _ExpenseRow({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Row(children: [const CircleAvatar(radius: 8, backgroundColor: MyColors.red,),const SizedBox(width: 10,), Text("Expense".tr(), style: MyTextStyles.textStyleMedium17)],),
      const Spacer(),
      Text(Utils.currencyToString(expenses), style: MyTextStyles.textStyleMedium17Red),
    ],);
  }
}

class _IncomeRow extends StatelessWidget {
  final double income;
  const _IncomeRow({super.key, required this.income});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Row(children: [const CircleAvatar(radius: 8, backgroundColor: MyColors.green,),const SizedBox(width: 10,), Text("Income".tr(), style: MyTextStyles.textStyleMedium17)],),
      const Spacer(),
      Text(Utils.currencyToString(income), style: MyTextStyles.textStyleMedium17Green),
    ],);
  }
}


class _BalanceRow extends StatelessWidget {
  final double balance;
  const _BalanceRow({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    print("balance: $balance");
    return Row(children: [
      Text("Balance".tr(), style: MyTextStyles.textStyle26,),
      const Spacer(),
      Text(getBalanceText(balance), style: getTextStyle(balance)),
    ],);
  }
}

TextStyle getTextStyle(balance){
  if(balance < 0){
    return MyTextStyles.textStyleBold20Red;
  }else if(balance > 0){
    return MyTextStyles.textStyleBold26Green;
  }else{
    return MyTextStyles.textStyleBold26Blue;
  }
}

String getBalanceText(balance){
  if(balance < 0){
    return "-${Utils.currencyToString(balance).replaceFirst('-', '')}";
  }else if(balance > 0){
    return "+${Utils.currencyToString(balance)}";
  }else{
    return Utils.currencyToString(balance);
  }
}