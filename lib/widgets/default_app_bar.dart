import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/pages/setting/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String title;

  const DefaultAppBar(
      {Key? key, required this.title}
      ) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize;

  @override
  State<StatefulWidget> createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(widget.title, style: MyTextStyles.appBarTitle,),
      actions: [IconButton(onPressed: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => const SettingPage()));
      }, icon: SvgPicture.asset("assets/images/settings-04.svg"), color: MyColors.white,)],

    );
  }
}
