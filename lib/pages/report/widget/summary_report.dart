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
  final String month;
  final String year;
  const SummaryReport({super.key,required this.year,required this.month, required this.income, required this.expenses, required this.callback});

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
          Padding(padding:const EdgeInsets.only(left: 20, top: 5),
          child: Row(children: [
            _YearDrop(onSelected: (value){
               widget.callback(value, widget.month);
            }),
            const SizedBox(width: 10,),
            _YearDrop(onSelected: (value){
              widget.callback(widget.year, value);
            }, isMonth: true,),
          ],)
          ),
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
  final bool isMonth;
  final Function onSelected;
  const _YearDrop({Key? key, required this.onSelected, this.isMonth = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YearDropDown();
}

class _YearDropDown extends State<_YearDrop> {
  List<DropdownMenuItem<String>> dropDownList = [];
  int currentYear = DateTime.now().year;
  String selectedValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isMonth){
      dropDownList=[
        const DropdownMenuItem(value: "", child: Text("All Months")),
        const DropdownMenuItem(value: "01", child: Text("January")),
        const DropdownMenuItem(value: "02", child: Text("February")),
        const DropdownMenuItem(value: "03", child: Text("March")),
        const DropdownMenuItem(value: "04", child: Text("April")),
        const DropdownMenuItem(value: "05", child: Text("May")),
        const DropdownMenuItem(value: "06", child: Text("June")),
        const DropdownMenuItem(value: "07", child: Text("July")),
        const DropdownMenuItem(value: "08", child: Text("August")),
        const DropdownMenuItem(value: "09", child: Text("September")),
        const DropdownMenuItem(value: "10", child: Text("October")),
        const DropdownMenuItem(value: "11", child: Text("November")),
        const DropdownMenuItem(value: "12", child: Text("December")),
      ];
    }else{
      selectedValue = Utils.dateFormatYear(DateTime.now());
      currentYear = DateTime.now().year;
      for (int i = currentYear - 5; i <= currentYear; i++) {
        dropDownList.add(DropdownMenuItem(value: i.toString(), child: Text(i.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    print("data " );
    return DropdownButton(
            underline: Container(),
            items: dropDownList,
            style: MyTextStyles.textStyleBold20,
            value: selectedValue,
            onChanged: (value) => setState(() {
              selectedValue = value!;
              widget.onSelected(value);
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
      Text('-${Utils.currencyToString(expenses)}', style: MyTextStyles.textStyleMedium17Red),
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
      Text('+${Utils.currencyToString(income)}', style: MyTextStyles.textStyleMedium17Green),
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