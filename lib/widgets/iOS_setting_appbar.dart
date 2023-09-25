import 'package:expenses_tracking/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosSettingAppBar extends StatefulWidget implements ObstructingPreferredSizeWidget{
  final String title;
  const IosSettingAppBar({super.key, required this.title});

  @override
  State<IosSettingAppBar> createState() => _IosSettingAppBarState();
  
  @override
  Size get preferredSize => const Size(double.infinity, 55);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return false;
  }
}

class _IosSettingAppBarState extends State<IosSettingAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height: 100,
          child: CupertinoNavigationBar(
            border: Border.all(color: Colors.transparent),
        backgroundColor: MyColors.white,
        middle: Text(widget.title, style: MyTextStyles.appBarTitleWhite,),
      ));
  }
}