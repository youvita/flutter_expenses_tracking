import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/pages/setting/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultIOSAppBar extends StatefulWidget implements ObstructingPreferredSizeWidget{
  final String title;
  const DefaultIOSAppBar({super.key, required this.title});

  @override
  State<DefaultIOSAppBar> createState() => _DefaultIOSAppBarState();
  
  @override
  Size get preferredSize => const Size(double.infinity, 55);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return false;
  }
}

class _DefaultIOSAppBarState extends State<DefaultIOSAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height: 100,
          child: CupertinoNavigationBar(
        backgroundColor: MyColors.blue,
        middle: Text(widget.title, style: MyTextStyles.appBarTitle,),
        trailing: CupertinoButton(
          onPressed: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context) => const SettingPage()));
          },
          padding: EdgeInsets.zero,
          child: SvgPicture.asset('assets/images/settings-04.svg')
        )
      ));
  }
}