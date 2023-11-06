import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/config/setting_utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/widgets/iOS_setting_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: IosSettingAppBar(title: 'Security'.tr()),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Text("Manage your mobile app more security and protects your data.", style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.grey
              ),)
            ),
            CupertinoListTile(
              title: Text("Pin Code"),
              leading: SvgPicture.asset('assets/images/password_pin.svg'),
              subtitle: Text("Login with pin code".tr()),
              trailing: CupertinoSwitch(value: Setting.isPin!, onChanged: (value){
                Setting.updatePin(value);
                setState(() {});
              }),
              ),
              SizedBox(height: 20,),
              CupertinoListTile(
              title: Text("Fingerprint"),
              leading: SvgPicture.asset('assets/images/fingerprint.svg'),
              subtitle: Text("Login faster to get access".tr()),
              trailing: CupertinoSwitch(value: Setting.isFingerPrint!, onChanged: (value){
                Setting.updateFingerPrint(value);
                setState(() {});
              })
              )
          ],),
        ),
      ));
  }
}