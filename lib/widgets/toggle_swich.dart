import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ExpenseToggle extends StatefulWidget {
  final Function onToggle;
  final double width;
  final bool isAll;
  final bool isEnable;
  final int defaultIndex;
  const ExpenseToggle({super.key, required this.onToggle, this.isAll=true, this.isEnable = true,this.width=double.infinity, this.defaultIndex=0});

  @override
  State<ExpenseToggle> createState() => _MyToggleSwitchState();
}

class _MyToggleSwitchState extends State<ExpenseToggle> {
  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      changeOnTap: widget.isEnable,
      cornerRadius: 7,
      initialLabelIndex: widget.defaultIndex,
      borderWidth: 1,
      borderColor: const [MyColors.black10],
      activeBgColors: widget.isAll ? [[MyColors.blue], [MyColors.red], [MyColors.green]] : [[MyColors.red], [MyColors.green]],
      inactiveBgColor: MyColors.white,
      radiusStyle: true,
      minWidth: widget.width,
      minHeight: 35,
      customTextStyles:const [MyTextStyles.switchStyle],
      inactiveFgColor: MyColors.black,
      activeFgColor: MyColors.white,
      totalSwitches: widget.isAll ? 3 : 2,
      labels: widget.isAll ? ['All'.tr(), 'Expense'.tr(), 'Income'.tr()] : ['Expense'.tr(), 'Income'.tr()],
      onToggle: (index) {
        widget.onToggle(index);
      },
    );
  }
}
