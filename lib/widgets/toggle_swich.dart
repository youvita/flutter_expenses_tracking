import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/constand/constand.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpenseToggle extends StatefulWidget {
  final Function onToggle;
  final double width;
  final bool isAll;
  const ExpenseToggle({super.key, required this.onToggle, this.isAll=true, this.width=double.infinity});

  @override
  State<ExpenseToggle> createState() => _MyToggleSwitchState();
}

class _MyToggleSwitchState extends State<ExpenseToggle> {
  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      cornerRadius: 7,
      initialLabelIndex: 0,
      borderWidth: 1,
      borderColor: const [MyColors.black10],
      activeBgColors:const [[MyColors.blue], [MyColors.red], [MyColors.green]],
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
